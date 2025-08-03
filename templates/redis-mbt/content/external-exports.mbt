///|
pub fn cabi_realloc(
  src_offset : Int,
  src_size : Int,
  _dst_alignment : Int,
  dst_size : Int,
) -> Int {
  @gen.cabi_realloc(src_offset, src_size, _dst_alignment, dst_size)
}

///|
pub fn wasmExportHandle(p0 : Int, p1 : Int) -> Unit {
  handle(
    @types.IncomingRequest::IncomingRequest(p0),
    @types.ResponseOutparam::ResponseOutparam(p1),
  )
}
