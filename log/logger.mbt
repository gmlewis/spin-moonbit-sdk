/// `info` prints a string prefixed with "INFO: " to wasi stderr with a newline.
pub fn info(s : String, ~leading_blank_line : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n").unwrap()
  }
  stderr.write(@base64.str2bytes("INFO: \{s}")).unwrap()
  stderr.blocking_write_and_flush(b"\n").unwrap()
}

/// `debug` prints a string prefixed with "DEBUG: " to wasi stderr with a newline.
pub fn debug(s : String, ~leading_blank_line : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n").unwrap()
  }
  stderr.write(@base64.str2bytes("DEBUG: \{s}")).unwrap()
  stderr.blocking_write_and_flush(b"\n").unwrap()
}

/// `warn` prints a string prefixed with "WARNING: " to wasi stderr with a newline.
pub fn warn(s : String, ~leading_blank_line : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n").unwrap()
  }
  stderr.write(@base64.str2bytes("WARNING: \{s}")).unwrap()
  stderr.blocking_write_and_flush(b"\n").unwrap()
}

/// `error` prints a string prefixed with "ERROR: " to wasi stderr with a newline.
pub fn error(s : String, ~leading_blank_line : Bool = false) -> Unit {
  let stderr = @stderr.get_stderr()
  if leading_blank_line {
    stderr.write(b"\n").unwrap()
  }
  stderr.write(@base64.str2bytes("ERROR: \{s}")).unwrap()
  stderr.blocking_write_and_flush(b"\n").unwrap()
}
