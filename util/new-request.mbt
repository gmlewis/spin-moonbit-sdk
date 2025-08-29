///|
/// `new_request` creates a new outgoing request.
pub fn new_request(
  method_ : @types.Method,
  url : String,
  fields? : Array[(String, Bytes)] = [],
) -> @types.OutgoingRequest {
  let req = @types.OutgoingRequest::outgoing_request(
    @types.Fields::from_list(fields.map(fn(p) { (p.0, p.1.to_fixedarray()) })).unwrap(),
  )
  req.set_method(method_).unwrap()
  let i = url.find("://")
  if i is Some(i) {
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
        req.set_authority(Some(authority.to_string())).unwrap()
        // let remainder = remainder.iter().collect().join("/")
        // Is this `map` really necessary?!?
        let remainder = remainder
          .iter()
          .map(fn(s) { s.to_string() })
          .collect()
          .join("/")
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
