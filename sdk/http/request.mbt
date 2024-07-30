/// `Request` represents an HTTP request.
pub struct Request {
  method : Method
  header : Header
  body : String?
}

/// `Request::builder` builds a new `Request` with default method "GET".
pub fn Request::builder() -> Request {
  { method: GET, header: Header::new(), body: None }
}

/// `method` sets the method of the Request.
pub fn method(self : Request, method : Method) -> Request {
  { ..self, method, }
}

/// `header` sets a header key/value pair in the Request.
pub fn header(self : Request, key : String, value : String) -> Request {
  let header = self.header
  header.set(key, value)
  { ..self, header, }
}

/// `body` sets the body of the Request.
pub fn body(self : Request, body : String) -> Request {
  { ..self, body: Some(body) }
}
