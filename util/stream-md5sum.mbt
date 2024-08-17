/// `stream_md5sum` performs a `GET` request on the provided `request`
/// then streams its output to the provided `response_out` and calculates
/// the stream's md5sum and content length, reporting them back to the caller.
/// `buf_size` cannot be more than 4096.
pub fn stream_md5sum(
  request : @types.OutgoingRequest,
  response_out : @types.ResponseOutparam,
  ~buf_size : UInt64 = 4096UL
) -> Result[(Int64, String), @types.ErrorCode] {
  if buf_size > 4096UL {
    return Err(@types.ErrorCode::InternalError(Some("buf_size max is 4096UL")))
  }
  let future = match @outgoingHandler.handle(request, None) {
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
  let in_stream = match incoming {
    Ok(body) => body.stream()
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 2")))
  }
  let in_stream = match in_stream {
    Ok(in_stream) => in_stream
    _ => return Err(@types.ErrorCode::InternalError(Some("unknown error 3")))
  }
  // TODO: Figure out why this doesn't work:
  // let content_type = match request.headers().get("Content-Type") {
  //   [content_type] => content_type
  //   _ => b"text/plain"
  // }
  let content_type = b"text/plain"
  let fields = @types.Fields::from_list([("Content-Type", content_type)]).unwrap()
  let out_resp = @types.OutgoingResponse::outgoing_response(fields)
  out_resp.set_status_code(200U).unwrap()
  let out_body = match out_resp.body() {
    Ok(body) => body
    Err(_) =>
      return Err(@types.ErrorCode::InternalError(Some("unknown error 4")))
  }
  let out_stream = match out_body.write() {
    Ok(stream) => stream
    Err(_) =>
      return Err(@types.ErrorCode::InternalError(Some("unknown error 5")))
  }
  response_out.set(out_resp |> Ok)
  //
  let mut count = 0L
  for {
    let buf = match in_stream.blocking_read(buf_size) {
      Ok(buf) => buf
      Err(e) => return Err(@types.ErrorCode::InternalError(Some(e.to_string())))
    }
    count += buf.length().to_int64()
    if buf.length() == 0 {
      break
    }
    match out_stream.blocking_write_and_flush(buf) {
      Ok(_) => if buf.length() < buf_size.to_int() { break }
      Err(e) => return Err(@types.ErrorCode::InternalError(Some(e.to_string())))
    }
  }
  // TODO: calculate the streaming md5sum
  Ok((count, ""))
}
