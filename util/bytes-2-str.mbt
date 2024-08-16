/// `bytes2str` decodes a UTF-8 `Bytes` to a UTF-16 `String`.
pub fn bytes2str(b : Bytes) -> String {
  (b.iter() |> @decoder.utf8()).to_string()
}
