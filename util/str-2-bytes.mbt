/// `str2bytes` encodes a UTF-16 `String` as a UTF-8 `Bytes`.
pub fn str2bytes(s : String) -> Bytes {
  s.iter() |> @encoder.utf8() |> Bytes::from_iter()
}
