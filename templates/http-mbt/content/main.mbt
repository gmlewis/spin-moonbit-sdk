///|
/// `handle` returns a simple response to a `GET {{http-path}}` request.
pub fn handle(
  request : @types.IncomingRequest,
  response_out : @types.ResponseOutparam,
) -> Unit {
  let response = (match request.path_with_query() {
      Some("{{http-path}}") => @util.make_response(b"Hello, World!\n")
      _ => return @util.respond_404(response_out)
    })
    |> Ok
  response_out.set(response)
}
