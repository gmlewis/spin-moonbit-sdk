fn init {
  @http.register(handle_hello_world)
}

pub fn handle_hello_world(req : @http.Request) -> @http.Response!String {
  if req.method != @http.Method::GET {
    raise "must use http method GET"
  }
  @http.Response::builder().status(200).header("content-type", "text/plain").body(
    "Hello, Fermyon from MoonBit SDK",
  )
}

// The following boilerplate code is only required until MoonBit supports
// exporting functions from "external" libs:

// Exported: `spin_http_handle_http_request` handles an incoming HTTP request.
pub fn spin_http_handle_http_request(
  req : @http.SpinHttpRequestT,
  res : @http.SpinHttpResponseT
) -> Unit {
  @http.spin_http_handle_http_request(req, res)
}

// Exported: This function will be exported as `handle-http-request` for the host to call.
pub fn handle_http_request(
  arg : Int,
  arg0 : Int,
  arg1 : Int,
  arg2 : Int,
  arg3 : Int,
  arg4 : Int,
  arg5 : Int,
  arg6 : Int,
  arg7 : Int,
  arg8 : Int
) -> Int {
  @http.handle_http_request(
    arg, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8,
  )
}

pub fn canonical_abi_realloc(
  ptr : Int,
  orig_size : Int,
  align : Int,
  new_size : Int
) -> Int {
  @http.canonical_abi_realloc(ptr, orig_size, align, new_size)
}

pub fn canonical_abi_free(ptr : Int, size : Int, align : Int) -> Unit {
  @http.canonical_abi_free(ptr, size, align)
}
