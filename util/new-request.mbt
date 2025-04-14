///|
/// `new_request` creates a new outgoing request.
pub fn new_request(
  http_method : @types.Method,
  url : String,
  fields~ : Array[(String, Bytes)] = []
) -> @types.OutgoingRequest {
  let req = @types.OutgoingRequest::outgoing_request(
    @types.Fields::from_list(fields).unwrap(),
  )
  req.set_method(http_method).unwrap()
  let i = url.index_of("://")
  if i > 0 {
    let scheme = match url.substring(end=i) {
      "http" => @types.Http
      "https" => @types.Https
      other => @types.Scheme::Other(other)
    }
    req.set_scheme(Some(scheme)).unwrap()
    let without_scheme = url.substring(start=i + 3)
    let parts = without_scheme.split("/").collect()
    match parts {
      [authority, .. remainder] => {
        req.set_authority(Some(authority)).unwrap()
        let remainder = remainder.iter().collect().join("/")
        let path_with_query = "/\{remainder}"
        req.set_path_with_query(Some(path_with_query)).unwrap()
      }
      _ => ()
    }
  } else {
    req.set_scheme(Some(@types.Http)).unwrap()
    req.set_path_with_query(Some(url)).unwrap()
  }
  req
}
