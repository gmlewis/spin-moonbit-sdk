// Copyright 2024 peter-jerry-ye
// SPDX-License-Identifier: MIT

pub fn utf8(bytes : Iter[Byte]) -> Iter[Char] {
  Iter::new(
    fn(f) {
      let mut len = 0
      let mut char = 0
      for byte in bytes {
        let b = byte.to_int()
        if len == 0 {
          if b < 0b1100_0000 {
            match f(Char::from_int((char << 6) | b)) {
              IterEnd => break IterEnd
              IterContinue => continue
            }
          } else if b < 0b1110_0000 {
            char = b & 0b11111
            len = 1
          } else if b < 0b1111_0000 {
            char = b & 0b1111
            len = 2
          } else if b < 0b1111_1000 {
            char = b & 0b111
            len = 3
          } else {
            break IterEnd
          }
        } else if (b >> 6) == 0b10 {
          char = (char << 6) | (b & 0b111111)
          len -= 1
          if len == 0 {
            match f(Char::from_int(char)) {
              IterEnd => break IterEnd
              IterContinue => {
                char = 0
                continue
              }
            }
          }
        } else {
          break IterEnd
        }
      } else {
        IterContinue
      }
    },
  )
}
