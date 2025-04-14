///|
/// `random_int` returns a random Int between [0..n). If n<=1, 0 is always returned.
pub fn random_int(n : Int) -> Int {
  if n > 1 {
    @random.get_random_u64().to_int().abs() % n
  } else {
    0
  }
}
