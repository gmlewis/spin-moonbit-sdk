/// `stream` performs the provided `request`
/// then streams its output to the provided `response_out` and optionally calculates
/// the stream's hash, reporting the byte count and hash back to the caller.
pub fn stream(
  request : @types.OutgoingRequest,
  response_out : @types.ResponseOutparam,
  hash : @common.HashFunc?,
  debug~ : Bool = false
) -> Result[(Int64, String), @types.ErrorCode] {
  let (byte_func, sum_func) = match hash {
    Some(hash) => {
      let byte_func : ByteFunc = fn(b) -> Unit { hash.write(b) }
      let sum_func = fn() -> String { hash.check_sum() }
      (Some(byte_func), sum_func)
    }
    _ => (None, fn() -> String { "" })
  }
  //
  match stream_func(request, response_out, byte_func, debug~) {
    Ok(count) => Ok((count, sum_func()))
    Err(e) => Err(e)
  }
}

/// `stream_func` performs the provided `request`
/// then streams its output to the provided `response_out` and runs the
/// provided `byte_func` on each byte, then returns the content length
/// back to the caller.
pub fn stream_func(
  request : @types.OutgoingRequest,
  response_out : @types.ResponseOutparam,
  byte_func : ByteFunc?,
  debug~ : Bool = false
) -> Result[Int64, @types.ErrorCode] {
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
  if debug {
    let status = incoming_response.status()
    @log.info("Status code = \{status}")
    dump_headers(incoming_headers)
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
  let content_type = match incoming_headers.get("Content-Type") {
    [value] => value
    _ => b"text/plain"
  }
  let fields_array = [("Content-Type", content_type)]
  match incoming_headers.get("Content-Length") {
    [value] => fields_array.push(("Content-Length", value))
    _ => ()
  }
  //
  let fields = @types.Fields::from_list(fields_array).unwrap()
  let out_resp = @types.OutgoingResponse::outgoing_response(fields)
  out_resp.set_status_code(200U).unwrap()
  let out_body = match out_resp.body() {
    Ok(body) => body
    Err(_) =>
      return Err(
        @types.ErrorCode::InternalError(Some("out_resp.body: unknown error 4")),
      )
  }
  let out_stream = match out_body.write() {
    Ok(stream) => stream
    Err(_) =>
      return Err(
        @types.ErrorCode::InternalError(Some("out_body.write: unknown error 5")),
      )
  }
  response_out.set(out_resp |> Ok)
  //
  let mut count = 0L
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
    count += buf.length().to_int64()
    if buf.length() == 0 {
      break
    }
    match byte_func {
      Some(f) =>
        for b in buf {
          (f._)(b)
        }
      _ => ()
    }
    match out_stream.blocking_write_and_flush(buf) {
      Ok(_) => ()
      Err(e) => {
        if e == @streams.Closed {
          break
        }
        let msg = e.to_string()
        @log.error("outstream.blocking_write_and_flush: \{msg}")
        return Err(@types.ErrorCode::InternalError(Some(msg)))
      }
    }
  }
  Ok(count)
}
