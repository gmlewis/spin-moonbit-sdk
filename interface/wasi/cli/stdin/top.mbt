// Generated by `wit-bindgen` 0.41.0. DO NOT EDIT!

///|
pub fn get_stdin() -> @streams.InputStream {
  let result : Int = wasmImportGetStdin()
  return @streams.InputStream::InputStream(result)
}
