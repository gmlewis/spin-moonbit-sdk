///|
pub fn cabi_realloc(
  src_offset : Int,
  src_size : Int,
  _dst_alignment : Int,
  dst_size : Int
) -> Int {
  // malloc
  if src_offset == 0 && src_size == 0 {
    return @ffi.malloc(dst_size)
  }
  // free
  if dst_size <= 0 {
    @ffi.free(src_offset)
    return 0
  }
  // realloc
  let dst = @ffi.malloc(dst_size)
  @ffi.copy(dst, src_offset)
  @ffi.free(src_offset)
  dst
}
