///|
/// `println` prints a string to wasi stdout with a newline.
pub fn println(s : String) -> Unit {
  let stdout = @stdout.get_stdout()
  stdout.write(@base64.str2bytes(s).to_fixedarray()).unwrap()
  stdout.blocking_write_and_flush(b"\n".to_fixedarray()).unwrap()
}
