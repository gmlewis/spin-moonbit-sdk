/// `send_request` sends an outgoing request and waits for the response.
pub fn send_request(
  req : @types.OutgoingRequest,
  ~max_body_size : UInt64 = 8192UL
) -> Result[Bytes, @types.ErrorCode] {
  let future = match @outgoingHandler.handle(req, None) {
    Ok(result) => result
    Err(e) => return Err(e)
  }
  let pollable = future.subscribe()
  pollable.block()
  let incoming = match future.get() {
    Some(Ok(Ok(result))) => result.consume()
    Some(Ok(Err(e))) => return Err(e)
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 1")))
  }
  let stream = match incoming {
    Ok(body) => body.stream()
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 2")))
  }
  let read = match stream {
    Ok(body) => body.blocking_read(max_body_size)
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 3")))
  }
  match read {
    Ok(bytes) => Ok(bytes)
    Err(e) => return Err(@types.ErrorCode::InternalError(Some(e.to_string())))
  }
}
