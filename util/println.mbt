pub fn println(s : String) -> Unit {
  @stderr.get_stderr().blocking_write_and_flush(str2bytes(s)).unwrap()
  @stderr.get_stderr().blocking_write_and_flush(b"\n").unwrap()
}
