/// `HashFunc` represents a hash algorithm like `@md5` or `@sha256`.
pub trait HashFunc {
  name(Self) -> String
  write(Self, Byte) -> Unit
  check_sum(Self) -> String
}
