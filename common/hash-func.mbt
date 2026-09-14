///|
/// `HashFunc` represents a hash algorithm like `@md5` or `@sha256`.
pub(open) trait HashFunc {
  fn name(Self) -> String
  fn write(Self, Byte) -> Unit
  fn check_sum(Self) -> String
}

///|
let _trait1 : &HashFunc = @md5.Digest::new()

///|
let _trait2 : &HashFunc = @sha256.Digest::new()

///|
pub impl HashFunc for @md5.Digest with fn name(self) {
  self.name()
}

///|
pub impl HashFunc for @md5.Digest with fn write(self, b) {
  self.write(b)
}

///|
pub impl HashFunc for @md5.Digest with fn check_sum(self) {
  self.check_sum()
}

///|
pub impl HashFunc for @sha256.Digest with fn name(self) {
  self.name()
}

///|
pub impl HashFunc for @sha256.Digest with fn write(self, b) {
  self.write(b)
}

///|
pub impl HashFunc for @sha256.Digest with fn check_sum(self) {
  self.check_sum()
}
