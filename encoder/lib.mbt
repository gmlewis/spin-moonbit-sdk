// Copyright 2024 peter-jerry-ye
// SPDX-License-Identifier: MIT

pub fn utf8(string : Iter[Char]) -> Iter[Byte] {
  Iter::new(
    fn(f) {
      for char in string {
        let point = char.to_int()
        if point < 0x80 {
          match f((((point >> 0) & 0x7F) | 0x00).to_byte()) {
            IterEnd => break IterEnd
            _ => continue
          }
        } else if point < 0x0800 {
          match f((((point >> 6) & 0x1F) | 0xC0).to_byte()) {
            IterEnd => break IterEnd
            _ => ()
          }
          match f((((point >> 0) & 0x3F) | 0x80).to_byte()) {
            IterEnd => break IterEnd
            _ => continue
          }
        } else if point < 0x10000 {
          match f((((point >> 12) & 0x0F) | 0xE0).to_byte()) {
            IterEnd => break IterEnd
            _ => ()
          }
          match f((((point >> 6) & 0x3F) | 0x80).to_byte()) {
            IterEnd => break IterEnd
            _ => ()
          }
          match f((((point >> 0) & 0x3F) | 0x80).to_byte()) {
            IterEnd => break IterEnd
            _ => continue
          }
        } else if point < 0x110000 {
          match f((((point >> 18) & 0x07) | 0xF0).to_byte()) {
            IterEnd => break IterEnd
            _ => ()
          }
          match f((((point >> 12) & 0x3F) | 0x80).to_byte()) {
            IterEnd => break IterEnd
            _ => ()
          }
          match f((((point >> 6) & 0x3F) | 0x80).to_byte()) {
            IterEnd => break IterEnd
            _ => ()
          }
          match f((((point >> 0) & 0x3F) | 0x80).to_byte()) {
            IterEnd => break IterEnd
            _ => continue
          }
        }
      } else {
        IterContinue
      }
    },
  )
}
