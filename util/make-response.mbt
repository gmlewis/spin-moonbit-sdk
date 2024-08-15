pub fn make_response(
  body : Bytes,
  ~status_code : UInt = 200
) -> @types.OutgoingResponse {
  let response = @types.outgoing_response(@types.fields())
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
