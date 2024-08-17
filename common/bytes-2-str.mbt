/// `bytes2str` decodes a UTF-8 `Bytes` to a UTF-16 `String`.
pub fn bytes2str(b : Bytes) -> String {
  let chars = (b.iter() |> @decoder.utf8()).collect()
  let buf = Buffer::new(size_hint=chars.length())
  for ch in chars {
    buf.write_char(ch)
  }
  buf.to_string()
}

test "bytes2str works on simple case" {
  let got = bytes2str(b"simple case")
  assert_eq!(got, "simple case")
}
