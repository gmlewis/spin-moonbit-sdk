pub fn make_response(
  body : Bytes,
  ~content_type : Bytes = b"text/plain",
  ~status_code : UInt = 200
) -> @types.OutgoingResponse {
  let fields = @types.Fields::from_list([("Content-Type", content_type)]).unwrap()
  let response = @types.outgoing_response(fields)
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

pub fn make_404_response() -> @types.OutgoingResponse {
  make_response(b"Not Found", status_code=404)
}

pub fn respond_404(response_out : @types.ResponseOutparam) -> Unit {
  response_out.set(make_404_response() |> Ok)
}

pub fn make_500_response() -> @types.OutgoingResponse {
  make_response(b"Internal Server Error", status_code=500)
}

pub fn respond_500(response_out : @types.ResponseOutparam) -> Unit {
  response_out.set(make_500_response() |> Ok)
}
