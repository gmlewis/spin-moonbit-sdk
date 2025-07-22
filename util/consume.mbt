///|
/// `ByteFunc` is a function that operates on a stream of bytes, one byte at a time.
type ByteFunc (Byte) -> Unit

///|
let max_buf_size = 4096UL

///|
/// `consume` performs the provided `request`
/// then consumes its output and optionally calculates
/// the stream's hash, reporting the byte count and hash back to the caller.
pub fn consume(
  request : @types.OutgoingRequest,
  hash : &@common.HashFunc?,
  debug~ : Bool = false,
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
  match consume_func(request, byte_func, debug~) {
    Ok(count) => Ok((count, sum_func()))
    Err(e) => Err(e)
  }
}

///|
/// `consume_func` performs the provided `request`
/// then consumes its output and runs the optional
/// `byte_func` on each byte, then returns the content length
/// back to the caller.
pub fn consume_func(
  request : @types.OutgoingRequest,
  byte_func : ByteFunc?,
  debug~ : Bool = false,
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
          f.inner()(b)
        }
      _ => ()
    }
  }
  Ok(count)
}
