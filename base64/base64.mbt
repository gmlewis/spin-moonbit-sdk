/// This package is based on the Go implementation found here:
/// https://cs.opensource.google/go/go/+/master:src/encoding/base64/base64.go
/// which has the copyright notice:
/// Copyright 2009 The Go Authors. All rights reserved.
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file.

/// `encode2bytes` base64-encodes the provided bytes using URL encoding.
pub fn encode2bytes(src : FixedArray[Byte]) -> Bytes {
  if src.length() == 0 {
    return Bytes::from_array([])
  }
  let buf = FixedArray::make(encoded_len(src.length()), b'\x00')
  encode_buf(buf, src)
  Bytes::from_iter(buf.iter())
}

fn encode_buf(dst : FixedArray[Byte], src : FixedArray[Byte]) -> Unit {
  let mut di = 0
  let mut si = 0
  let n = src.length() / 3 * 3
  while si < n {
    // Convert 3x 8bit source bytes into 4 bytes
    let val = (src[si + 0].to_uint() << 16) |
      (src[si + 1].to_uint() << 8) |
      src[si + 2].to_uint()
    dst[di + 0] = encode[((val >> 18) & 0x3F).to_int()]
    dst[di + 1] = encode[((val >> 12) & 0x3F).to_int()]
    dst[di + 2] = encode[((val >> 6) & 0x3F).to_int()]
    dst[di + 3] = encode[(val & 0x3F).to_int()]
    si += 3
    di += 4
  }
  let remain = src.length() - si
  if remain == 0 {
    return
  }
  // Add the remaining small block
  let mut val = src[si + 0].to_uint() << 16
  if remain == 2 {
    val = val | (src[si + 1].to_uint() << 8)
  }
  dst[di + 0] = encode[((val >> 18) & 0x3F).to_int()]
  dst[di + 1] = encode[((val >> 12) & 0x3F).to_int()]
  match remain {
    2 => {
      dst[di + 2] = encode[((val >> 6) & 0x3F).to_int()]
      dst[di + 3] = pad_char
    }
    1 => {
      dst[di + 2] = pad_char
      dst[di + 3] = pad_char
    }
    _ => ()
  }
}

fn encoded_len(n : Int) -> Int {
  (n + 2) / 3 * 4 // minimum # 4-char quanta, 3 bytes each
}

// URL encoding:
let encode : FixedArray[Byte] = FixedArray::from_array(
  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
  .to_array()
  .map(fn(c) { c.to_int().to_byte() }),
)

// let decode_map : FixedArray[Byte] = FixedArray::make(256, b'\xff')

let pad_char = b'='
