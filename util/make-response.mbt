///|
/// `make_response` makes a new `OutgoingResponse`.
pub fn make_response(
  body : FixedArray[Byte],
  content_type~ : FixedArray[Byte] = b"text/plain".to_fixedarray(),
  status_code~ : UInt = 200
) -> @types.OutgoingResponse {
  let fields = @types.Fields::from_list([("Content-Type", content_type)]).unwrap()
  let response = @types.OutgoingResponse::outgoing_response(fields)
  response
  .body()
  .unwrap()
  .write()
  .unwrap()
  .blocking_write_and_flush(body)
  .unwrap()
  response.set_status_code(status_code).unwrap()
  response
}

///|
/// `respond_bytes` sets response_out to an `OutgoingResponse` from the provided inputs.
pub fn respond_bytes(
  response_out : @types.ResponseOutparam,
  body : FixedArray[Byte],
  content_type~ : FixedArray[Byte] = b"text/plain".to_fixedarray(),
  status_code~ : UInt = 200
) -> Unit {
  response_out.set(make_response(body, content_type~, status_code~) |> Ok)
}

///|
/// `make_response_str` makes a new `OutgoingResponse` from the provided `String`.
pub fn make_response_str(
  body : String,
  content_type~ : FixedArray[Byte] = b"text/plain".to_fixedarray(),
  status_code~ : UInt = 200
) -> @types.OutgoingResponse {
  let body = @base64.str2bytes(body).to_fixedarray()
  make_response(body, content_type~, status_code~)
}

///|
/// `respond_str` sets response_out to an `OutgoingResponse` from the provided `String`.
pub fn respond_str(
  response_out : @types.ResponseOutparam,
  body : String,
  content_type~ : FixedArray[Byte] = b"text/plain".to_fixedarray(),
  status_code~ : UInt = 200
) -> Unit {
  response_out.set(make_response_str(body, content_type~, status_code~) |> Ok)
}

///|
/// `make_404_response` makes a new `OutgoingResponse` with "404 Not Found".
pub fn make_404_response() -> @types.OutgoingResponse {
  make_response(b"Not Found".to_fixedarray(), status_code=404)
}

///|
/// `respond_404` sets response_out to an `OutgoingResponse` with "404 Not Found".
pub fn respond_404(response_out : @types.ResponseOutparam) -> Unit {
  response_out.set(make_404_response() |> Ok)
}

///|
/// `make_500_response` makes a new `OutgoingResponse` with "500 Internal Server Error".
pub fn make_500_response() -> @types.OutgoingResponse {
  make_response(b"Internal Server Error".to_fixedarray(), status_code=500)
}

///|
/// `respond_500` sets response_out to an `OutgoingResponse` with "500 Internal Server Error".
pub fn respond_500(response_out : @types.ResponseOutparam) -> Unit {
  response_out.set(make_500_response() |> Ok)
}
