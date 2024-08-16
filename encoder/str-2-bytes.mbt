/// `str2bytes` added by Glenn Lewis for convenience.
pub fn str2bytes(s : String) -> Bytes {
  s.iter() |> utf8() |> Bytes::from_iter()
}
