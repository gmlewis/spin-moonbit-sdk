///|
let redis_address = "redis://localhost:6379/"

///|
/// `handle` handles a `GET {{http-path}}` request, sets a `test` key in Redis
/// then performs a `get` from Redis and returns the results.
pub fn handle(
  request : @types.IncomingRequest,
  response_out : @types.ResponseOutparam,
) -> Unit {
  let conn = match @redis.Connection::open(redis_address) {
    Ok(redis) => redis
    _ => return @util.respond_500(response_out)
  }
  let response = (match @util.split_path(request) {
      (@types.Get, ["{{ http-path | replace_first: "/", "" }}"]) => handle_get(conn)
      _ => return @util.respond_404(response_out)
    })
    |> Ok
  response_out.set(response)
}

///|
fn handle_get(conn : @redis.Connection) -> @types.OutgoingResponse {
  match conn.set("test", b"Hello, World!\n".to_fixedarray()) {
    Ok(_) => ()
    _ => return @util.make_500_response()
  }
  match conn.get("test") {
    Ok(Some(result)) => @util.make_response(Bytes::from_fixedarray(result))
    _ => @util.make_404_response()
  }
}
