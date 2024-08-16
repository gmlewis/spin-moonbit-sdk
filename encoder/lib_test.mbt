// Copyright 2024 peter-jerry-ye
// SPDX-License-Identifier: MIT

test "utf8" {
  @encoder.utf8("abcd".iter()).collect()
  |> inspect!(content="[b'\\x61', b'\\x62', b'\\x63', b'\\x64']")
  @encoder.utf8("中文❤♥".iter()).collect()
  |> inspect!(
    content="[b'\\xE4', b'\\xB8', b'\\xAD', b'\\xE6', b'\\x96', b'\\x87', b'\\xE2', b'\\x9D', b'\\xA4', b'\\xE2', b'\\x99', b'\\xA5']",
  )
}
