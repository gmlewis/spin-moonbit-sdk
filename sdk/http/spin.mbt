pub struct SpinHttpStringT {
  ptr : Int // char *ptr
  len : Int // size_t len
}

pub struct SpinHttpBodyT {
  ptr : Int // uint8_t *ptr
  len : Int // size_t len
}

pub struct SpinHttpTuple2StringStringT {
  f0 : SpinHttpStringT
  f1 : SpinHttpStringT
}

pub struct SpinHttpHeadersT {
  ptr : SpinHttpTuple2StringStringT // spin_http_tuple2_string_string_t *ptr
  len : Int // size_t len
}

pub enum SpinHttpHttpErrorT { // uint8_t
  SUCCESS // 0
  DESTINATION_NOT_ALLOWED // 1
  INVALID_URL // 2
  REQUEST_ERROR // 3
  RUNTIME_ERROR // 4
  TOO_MANY_REQUESTS // 5
} derive(Eq, Show)

pub type SpinHttpHttpStatusT Int // uint16_t

pub enum SpinHttpMethodT { // uint8_t
  GET // 0
  POST // 1
  PUT // 2
  DELETE // 3
  PATCH // 4
  HEAD // 5
  OPTIONS // 6
} derive(Eq, Show)

pub struct SpinHttpParamsT {
  ptr : SpinHttpTuple2StringStringT // spin_http_tuple2_string_string_t *ptr
  len : Int // size_t len
}

pub type SpinHttpUriT SpinHttpStringT

pub struct SpinHttpOptionBodyT {
  is_some : Bool
  val : SpinHttpBodyT
}

pub struct SpinHttpRequestT {
  method : SpinHttpMethodT
  uri : SpinHttpUriT
  headers : SpinHttpHeadersT
  params : SpinHttpParamsT
  body : SpinHttpOptionBodyT
}

pub struct SpinHttpOptionHeadersT {
  is_some : Bool
  val : SpinHttpHeadersT
}

pub struct SpinHttpResponseT {
  status : SpinHttpHttpStatusT
  headers : SpinHttpOptionHeadersT
  body : SpinHttpOptionBodyT
}

// unsafe_bytes will be replaced by external manipulation of the .wat file
// and then converted back to .wasm by `wat2wasm`:
fn unsafe_bytes(ptr : Int, len : Int) -> Bytes {
  let arr : Array[Int] = []
  Bytes::from_array(arr)
}

let header_full_url = "spin-full-url"

/// Exported: `spin_http_handle_http_request` handles an incoming HTTP request.
pub fn spin_http_handle_http_request(
  req : SpinHttpRequestT,
  res : SpinHttpResponseT
) -> Unit {
  // var body []byte
  let body_utf8 : Bytes? = if req.body.is_some {
    // 	body = C.GoBytes(unsafe.Pointer(req.body.val.ptr), C.int(req.body.val.len))
    Some(unsafe_bytes(req.body.val.ptr, req.body.val.len))
  } else {
    None
  }
  //
  let method = req.method.to_string()
  let header = Header::from_spin_headers(req.headers)
  let url = header.get(header_full_url)
  let req = Request::builder()
  // r, err := http.NewRequest(method, url, bytes.NewReader(body))
  // if err != nil {
  // 	fmt.Fprintln(os.Stderr, err)
  // 	res.status = C.uint16_t(http.StatusInternalServerError)
  // 	return
  // }

  // r.Header = header
  // r.Host = r.Header.Get("Host")
  // r.RequestURI = C.GoStringN(req.uri.ptr, C.int(req.uri.len))
  // r.RemoteAddr = r.Header.Get(HeaderClientAddr)

  // w := newResponse()

  // // call user function
  // handler(w, r)

  // res.status = C.uint16_t(w.status)
  // if len(w.header) > 0 {
  // 	res.headers = C.spin_http_option_headers_t{
  // 		is_some: true,
  // 		val:     toSpinHeaders(w.header),
  // 	}
  // } else {
  // 	res.headers = C.spin_http_option_headers_t{is_some: false}
  // }

  // res.body, err = toSpinBody(w.w)
  // if err != nil {
  // 	fmt.Fprintln(os.Stderr, err)
  // }
}

/// Exported: This function will be exported as `handle-http-request` for the host to call.
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
  // TODO
  0
}

// void *canonical_abi_realloc(void *ptr, size_t orig_size, size_t align, size_t new_size)
pub fn canonical_abi_realloc(
  ptr : Int,
  orig_size : Int,
  align : Int,
  new_size : Int
) -> Int {
  if new_size == 0 {
    return align
  }
  // void *ret = realloc(ptr, new_size);
  // if (!ret) abort();
  // return ret;
  panic() // TODO
  ptr
}

pub fn canonical_abi_free(ptr : Int, size : Int, align : Int) -> Unit {
  if size == 0 {
    return
  }
  // free(ptr);  // TODO
}
