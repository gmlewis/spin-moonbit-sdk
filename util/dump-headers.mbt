///|
/// `dump_headers` dumps the headers to stderr as INFO lines.
pub fn dump_headers(headers : @types.Fields) -> Unit {
  for entry in headers.entries() {
    let key = entry.0
    let value = @base64.bytes2str(entry.1)
    @log.info("Header['\{key}'] = '\{value}'")
  }
}
