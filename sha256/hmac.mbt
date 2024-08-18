/// This package is based on the Go implementation found here:
/// https://cs.opensource.google/go/go/+/refs/tags/go1.23.0:src/crypto/hmac/hmac.go
/// which has the copyright notice:
/// Copyright 2009 The Go Authors. All rights reserved.
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file.

/// `gen_hmac` generates a base64-encoded String representing
/// the SHA256 signature of the provided `body` using the provided
/// `client_secret` key.
pub fn gen_hmac(body : Bytes, client_secret : Bytes) -> String {
  let h = HMAC::new(client_secret)
  for b in body {
    h.inner.write(b)
  }
  let buf = h.sum()
  @base64.url_encode2str(buf)
}

struct HMAC {
  opad : FixedArray[Byte]
  ipad : FixedArray[Byte]
  outer : Digest
  inner : Digest
}

fn HMAC::new(key : Bytes) -> HMAC {
  let hm = {
    opad: FixedArray::make(block_size, b'\x00'),
    ipad: FixedArray::make(block_size, b'\x00'),
    outer: Digest::new(),
    inner: Digest::new(),
  }
  // If key is too big, hash it.
  let mut key = FixedArray::from_iter(key.iter())
  if key.length() > block_size {
    for b in key {
      hm.outer.write(b)
    }
    key = hm.outer.sum()
  }
  // copy
  for index, b in key {
    hm.ipad[index] = b
    hm.opad[index] = b
  }
  for index, b in hm.ipad {
    hm.ipad[index] = b ^ b'\x36'
    hm.inner.write(hm.ipad[index])
  }
  for index, b in hm.opad {
    hm.opad[index] = b ^ b'\x5c'
  }
  hm
}

fn sum(self : HMAC) -> FixedArray[Byte] {
  let inner_sum = self.inner.sum()
  self.outer.reset()
  for b in self.opad {
    self.outer.write(b)
  }
  for b in inner_sum {
    self.outer.write(b)
  }
  self.outer.sum()
}
