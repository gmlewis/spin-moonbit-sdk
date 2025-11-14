///|
/// `get_body_bytes` returns the incoming request body as `Bytes`.
pub fn get_body_bytes(
  request : @types.IncomingRequest,
) -> Result[Bytes, @streams.StreamError] {
  let in_stream = match request.consume() {
    Ok(body) => body.stream()
    _ => return Err(@streams.StreamError::Closed)
  }
  let in_stream = match in_stream {
    Ok(in_stream) => in_stream
    _ => return Err(@streams.StreamError::Closed)
  }
  //
  let content_length = match request.headers().get("Content-Length") {
    [value] =>
      @strconv.parse_int(@base64.bytes2str(Bytes::from_array(value))) catch {
        _ => return Err(@streams.StreamError::Closed)
      }
    _ => return Err(@streams.StreamError::Closed)
  }
  let result = @buffer.new(size_hint=content_length)
  for {
    let buf = match in_stream.blocking_read(max_buf_size) {
      Ok(buf) => buf
      Err(e) => {
        if e == @streams.Closed {
          break
        }
        let msg = e.to_string()
        @log.error("in_stream.blocking_read: \{msg}")
        return Err(@streams.StreamError::Closed)
      }
    }
    if buf.length() == 0 {
      break
    }
    result.write_iter(buf.iter())
  }
  Ok(result.to_bytes())
}
