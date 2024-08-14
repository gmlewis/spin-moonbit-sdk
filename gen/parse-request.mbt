pub fn split_path(
  request : @types.IncomingRequest
) -> (@types.Method, Array[String]) {
  let method = request.method()
  let result = match request.path_with_query() {
    Some(s) => s.split("/").collect()
    _ => []
  }
  (method, result)
}
