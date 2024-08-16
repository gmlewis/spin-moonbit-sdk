/// `get_body_bytes` returns the incoming request body as `Bytes`.
pub fn get_body_bytes(
  request : @types.IncomingRequest,
  ~max_body_size : UInt64 = 8192UL
) -> Result[Bytes, @streams.StreamError] {
  let body = match request.consume() {
    Ok(body) => body.stream()
    _ => return Err(@streams.StreamError::Closed)
  }
  match body {
    Ok(body) => body.blocking_read(max_body_size)
    _ => return Err(@streams.StreamError::Closed)
  }
}
