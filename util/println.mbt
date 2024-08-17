/// `println` prints a string to wasi stdout with a newline.
pub fn println(s : String) -> Unit {
  let stdout = @stdout.get_stdout()
  stdout.write(@common.str2bytes(s)).unwrap()
  stdout.blocking_write_and_flush(b"\n").unwrap()
}
