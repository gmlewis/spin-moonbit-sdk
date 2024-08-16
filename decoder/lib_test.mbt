// Copyright 2024 peter-jerry-ye
// SPDX-License-Identifier: MIT

test "utf8" {
  @decoder.utf8([b'a', b'b', b'c'].iter()).collect()
  |> inspect!(content="['a', 'b', 'c']")
  @decoder.utf8([b'\xe2', b'\x99', b'\xa5'].iter()).collect()
  |> inspect!(content="['♥']")
}
