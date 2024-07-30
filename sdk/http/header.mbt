/// `Header` represents an HTTP Request header.
/// Multiple values for a single key are not deduped.
pub type Header Map[String, String]

/// `Header::new` returns a new Header.
pub fn Header::new() -> Header {
  Header(Map::new())
}

impl @jsonutil.ToJson for Header with to_json(self) {
  let pairs = self.0.iter().map(
      fn { (k, v) => (k, @json.JsonValue::String(v)) },
    ).collect()
    |> Map::from_array()
  @json.JsonValue::Object(pairs)
}

/// `add` adds a value to a named (by `key`) header field.
/// If the header key already exists, the value is appended after a comma.
pub fn add(self : Header, key : String, value : String) -> Unit {
  match self.0.get(key) {
    Some(v) => self.0[key] = "\(v),\(value)"
    None => self.0[key] = value
  }
}

/// `get` returns the header value associated with a key.
pub fn get(self : Header, key : String) -> String? {
  self.0.get(key)
}

/// `set` overwrites a value to a named (by `key`) header field.
pub fn set(self : Header, key : String, value : String) -> Unit {
  self.0[key] = value
}

test "add" {
  let h = Header::new()
  h.add("key1", "one")
  h.add("key2", "one")
  h.add("key2", "two")
  h.add("key2", "two")
  @test.eq!(h.0.get("nokey"), None)
  @test.eq!(h.0.get("key1"), Some("one"))
  @test.eq!(h.0.get("key2"), Some("one,two,two"))
}

fn Header::from_spin_headers(headers : SpinHttpHeadersT) -> Header {
  {  }
}
