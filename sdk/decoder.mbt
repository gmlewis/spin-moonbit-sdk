pub fn decode(b : Bytes) -> String {
  // TODO: Make a real UTF-8 => UTF-16 converter.
  // For now, support ASCII.
  // https://github.com/moonbitlang/core/issues/484
  let length = b.length()
  let buf = Buffer::make(2 * length)
  let mut i = 0
  while i < length {
    let byte = b[i].to_int()
    let char = Char::from_int(byte)
    // println("to_utf16: b[\(i)]=\(byte)=\(char)")
    buf.write_char(char)
    i += 1
  }
  buf.to_string()
}
