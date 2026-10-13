///|
/// `info` prints a string prefixed with "INFO: " to wasi stderr with a newline.
pub fn info(s : String, leading_blank_line~ : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n".to_fixedarray()).unwrap()
  }
  stderr.write(@base64.str2bytes("INFO: \{s}").to_fixedarray()).unwrap()
  stderr.blocking_write_and_flush(b"\n".to_fixedarray()).unwrap()
}

///|
/// `debug` prints a string prefixed with "DEBUG: " to wasi stderr with a newline.
pub fn debug(s : String, leading_blank_line~ : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n".to_fixedarray()).unwrap()
  }
  stderr.write(@base64.str2bytes("DEBUG: \{s}").to_fixedarray()).unwrap()
  stderr.blocking_write_and_flush(b"\n".to_fixedarray()).unwrap()
}

///|
/// `warn` prints a string prefixed with "WARNING: " to wasi stderr with a newline.
pub fn warn(s : String, leading_blank_line~ : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n".to_fixedarray()).unwrap()
  }
  stderr.write(@base64.str2bytes("WARNING: \{s}").to_fixedarray()).unwrap()
  stderr.blocking_write_and_flush(b"\n".to_fixedarray()).unwrap()
}

///|
/// `error` prints a string prefixed with "ERROR: " to wasi stderr with a newline.
pub fn error(s : String, leading_blank_line~ : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n".to_fixedarray()).unwrap()
  }
  stderr.write(@base64.str2bytes("ERROR: \{s}").to_fixedarray()).unwrap()
  stderr.blocking_write_and_flush(b"\n".to_fixedarray()).unwrap()
}
