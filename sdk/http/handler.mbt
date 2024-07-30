let handler : Ref[Handler] = { val: default_handler }

// `default_handler` is a placeholder for returning a useful error to stderr when
// the handler is not set.
fn default_handler(_req : Request) -> Response!String {
  let msg = "http handler undefined"
  // println(msg)  // This adds a "spectest:print_char" export requirement on the host.
  raise msg
}

/// `Handler` represents an HTTP handler.
pub type Handler (Request) -> Response!String

/// `register` registers a `Handler` to the Spin host.
pub fn register(h : Handler) -> Unit {
  handler.val = h
}
