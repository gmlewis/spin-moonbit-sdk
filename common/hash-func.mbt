///| `HashFunc` represents a hash algorithm like `@md5` or `@sha256`.
pub(open) trait HashFunc {
  name(Self) -> String
  write(Self, Byte) -> Unit
  check_sum(Self) -> String
}

///|
let _trait1 : &HashFunc = @md5.Digest::new()

///|
let _trait2 : &HashFunc = @sha256.Digest::new()

///|
pub impl HashFunc for @md5.Digest with name(self) {
  self.name()
}

///|
pub impl HashFunc for @md5.Digest with write(self, b) {
  self.write(b)
}

///|
pub impl HashFunc for @md5.Digest with check_sum(self) {
  self.check_sum()
}

///|
pub impl HashFunc for @sha256.Digest with name(self) {
  self.name()
}

///|
pub impl HashFunc for @sha256.Digest with write(self, b) {
  self.write(b)
}

///|
pub impl HashFunc for @sha256.Digest with check_sum(self) {
  self.check_sum()
}
