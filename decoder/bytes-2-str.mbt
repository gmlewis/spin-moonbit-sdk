/// `bytes2str` added by Glenn Lewis for convenience.
pub fn bytes2str(b : Bytes) -> String {
  (b.iter() |> utf8()).to_string()
}
