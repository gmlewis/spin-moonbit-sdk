/// `send_request` sends an outgoing request and waits for the response.
// pub fn send_request(
//   req : @types.OutgoingRequest,
//   ~max_body_size : UInt64 = 8192UL
// ) -> Result[Bytes, @types.ErrorCode] {
//   let future = match @outgoingHandler.handle(req, None) {
//     Ok(result) => result
//     Err(e) => return Err(e)
//   }
//   let pollable = future.subscribe()
//   pollable.block()
//   let incoming = match future.get() {
//     Some(Ok(Ok(result))) => result.consume()
//     Some(Ok(Err(e))) => return Err(e)
//     _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 1")))
//   }
//   let stream = match incoming {
//     Ok(body) => body.stream()
//     _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 2")))
//   }
//   let read = match stream {
//     Ok(body) => body.blocking_read(max_body_size)
//     _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 3")))
//   }
//   match read {
//     Ok(bytes) => Ok(bytes)
//     Err(e) => return Err(@types.ErrorCode::InternalError(Some(e.to_string())))
//   }
// }

///|
/// `send_request` sends an outgoing request and waits for the response.
pub fn send_request(
  request : @types.OutgoingRequest,
  debug~ : Bool = false
) -> Result[Bytes, @types.ErrorCode] {
  let future = match @outgoingHandler.handle(request, None) {
    Ok(result) => result
    Err(e) => return Err(e)
  }
  let pollable = future.subscribe()
  pollable.block()
  let incoming_response = match future.get() {
    Some(Ok(Ok(result))) => result
    Some(Ok(Err(e))) => return Err(e)
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 1")))
  }
  //
  let incoming_headers = incoming_response.headers()
  let content_length = get_content_length(incoming_headers)
  if debug {
    let status = incoming_response.status()
    @log.info("Status code = \{status}, content-length=\{content_length}")
    dump_headers(incoming_headers)
  }
  let result = match content_length {
    0 => @buffer.new()
    size_hint => @buffer.new(size_hint~)
  }
  //
  let in_stream = match incoming_response.consume() {
    Ok(body) => body.stream()
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 2")))
  }
  let in_stream = match in_stream {
    Ok(in_stream) => in_stream
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 3")))
  }
  //
  for {
    let buf = match in_stream.blocking_read(max_buf_size) {
      Ok(buf) => buf
      Err(e) => {
        if e == @streams.Closed {
          break
        }
        let msg = e.to_string()
        @log.error("in_stream.blocking_read: \{msg}")
        return Err(@types.ErrorCode::InternalError(Some(msg)))
      }
    }
    if buf.length() == 0 {
      break
    }
    result.write_bytes(buf)
  }
  Ok(result.to_bytes())
}

// `get_content_length` returns the `Content-Length` header or 0 if it doesn't exist.
///|
pub fn get_content_length(fields : @types.Fields) -> Int {
  match fields.get("Content-Length") {
    [value] =>
      try {
        @strconv.parse_int!(@base64.bytes2str(value))
      } catch {
        _ => 0
      }
    _ => 0
  }
}
