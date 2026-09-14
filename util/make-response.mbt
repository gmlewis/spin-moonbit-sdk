///|
/// `max_write_size` is the largest buffer the host accepts in a single
/// `blocking_write_and_flush` call; a larger one traps the component.
let max_write_size = 4096

///|
/// `new_response` makes a new `OutgoingResponse` with no body written yet.
fn new_response(
  content_type : Bytes,
  status_code : UInt,
) -> @types.OutgoingResponse {
  let fields = @types.Fields::from_list([
    ("Content-Type", content_type.to_fixedarray()),
  ]).unwrap()
  let response = @types.OutgoingResponse::outgoing_response(fields)
  response.set_status_code(status_code).unwrap()
  response
}

///|
/// `write_all` writes `body` to `out_stream` in `max_write_size` chunks.
fn write_all(
  out_stream : @streams.OutputStream,
  body : Bytes,
) -> Result[Unit, @streams.StreamError] {
  let len = body.length()
  let mut offset = 0
  while offset < len {
    let end = if len - offset < max_write_size {
      len
    } else {
      offset + max_write_size
    }
    let chunk = match body.get_view(start=offset, end~) {
      Some(view) => view.to_fixedarray()
      None => break
    }
    match out_stream.blocking_write_and_flush(chunk) {
      Ok(_) => ()
      Err(e) => return Err(e)
    }
    offset = end
  }
  Ok(())
}

///|
/// `make_response` makes a new `OutgoingResponse` with the provided body.
///
/// The body is written before the response is handed to the host, so this is
/// only suitable for bodies of at most `max_write_size` bytes. Use
/// `respond_bytes` or `stream` for anything larger.
pub fn make_response(
  body : Bytes,
  content_type? : Bytes = b"text/plain",
  status_code? : UInt = 200,
) -> @types.OutgoingResponse {
  let response = new_response(content_type, status_code)
  let out_stream = response.body().unwrap().write().unwrap()
  write_all(out_stream, body).unwrap()
  response
}

///|
/// `respond_bytes` sets response_out to an `OutgoingResponse` from the provided inputs.
///
/// The body stream is opened before the response headers are handed to the
/// host, and the body is then written after them, exactly as `stream` does it.
/// Writing the whole body before handing over the headers blocks the host as
/// soon as the body outgrows its internal buffer.
pub fn respond_bytes(
  response_out : @types.ResponseOutparam,
  body : Bytes,
  content_type? : Bytes = b"text/plain",
  status_code? : UInt = 200,
) -> Unit {
  let response = new_response(content_type, status_code)
  let out_stream = response.body().unwrap().write().unwrap()
  response_out.set(response |> Ok)
  write_all(out_stream, body).unwrap()
}

///|
/// `make_response_str` makes a new `OutgoingResponse` from the provided `String`.
pub fn make_response_str(
  body : String,
  content_type? : Bytes = b"text/plain",
  status_code? : UInt = 200,
) -> @types.OutgoingResponse {
  make_response(@base64.str2bytes(body), content_type~, status_code~)
}

///|
/// `respond_str` sets response_out to an `OutgoingResponse` from the provided `String`.
pub fn respond_str(
  response_out : @types.ResponseOutparam,
  body : String,
  content_type? : Bytes = b"text/plain",
  status_code? : UInt = 200,
) -> Unit {
  respond_bytes(
    response_out,
    @base64.str2bytes(body),
    content_type~,
    status_code~,
  )
}

///|
/// `respond_404` sets response_out to an `OutgoingResponse` with "404 Not Found".
pub fn respond_404(response_out : @types.ResponseOutparam) -> Unit {
  respond_bytes(response_out, b"Not Found", status_code=404)
}

///|
/// `respond_500` sets response_out to an `OutgoingResponse` with "500 Internal Server Error".
pub fn respond_500(response_out : @types.ResponseOutparam) -> Unit {
  respond_bytes(response_out, b"Internal Server Error", status_code=500)
}

///|
/// `make_404_response` makes a new `OutgoingResponse` with "404 Not Found".
pub fn make_404_response() -> @types.OutgoingResponse {
  make_response(b"Not Found", status_code=404)
}

///|
/// `make_500_response` makes a new `OutgoingResponse` with "500 Internal Server Error".
pub fn make_500_response() -> @types.OutgoingResponse {
  make_response(b"Internal Server Error", status_code=500)
}
