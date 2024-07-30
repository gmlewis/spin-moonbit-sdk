/// `Response` represents an HTTP response.
pub struct Response {
  header : Header
  status_code : Int
  body : String
}

/// `Response::builder` builds a new `Response`.
pub fn Response::builder() -> Response {
  { header: Header::new(), status_code: 0, body: "" }
}

/// `status` sets the status code of the response.
pub fn status(self : Response, code : Int) -> Response {
  { ..self, status_code: code }
}

/// `body` sets the body of the response.
pub fn body(self : Response, body : String) -> Response {
  { ..self, body, }
}

/// `header` sets a header key/value pair in the response.
pub fn header(self : Response, key : String, value : String) -> Response {
  let header = self.header
  header.set(key, value)
  { ..self, header, }
}
