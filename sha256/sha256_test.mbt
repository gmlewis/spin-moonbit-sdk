/// This package is based on the Go implementation found here:
/// https://cs.opensource.google/go/go/+/refs/tags/go1.23.0:src/crypto/sha256/sha256_test.go
/// which has the copyright notice:
/// Copyright 2009 The Go Authors. All rights reserved.
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file.

struct SHA256Test {
  out : String
  s : String
}

let golden : Array[SHA256Test] = [
  {
    out: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    s: "",
  },
  {
    out: "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb",
    s: "a",
  },
  {
    out: "fb8e20fc2e4c3f248c60c39bd652f3c1347298bb977b8b4d5903b85055620603",
    s: "ab",
  },
  {
    out: "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
    s: "abc",
  },
  {
    out: "88d4266fd4e6338d13b845fcf289579d209c897823b9217da3e161936f031589",
    s: "abcd",
  },
  {
    out: "36bbe50ed96841d10443bcb670d6554f0a34b761be67ec9c4a8ad2c0c44ca42c",
    s: "abcde",
  },
  {
    out: "bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721",
    s: "abcdef",
  },
  {
    out: "7d1a54127b222502f5b79b5fb0803061152a44f92b37e23c6527baf665d4da9a",
    s: "abcdefg",
  },
  {
    out: "9c56cc51b374c3ba189210d5b6d4bf57790d351c96c47c02190ecf1e430635ab",
    s: "abcdefgh",
  },
  {
    out: "19cc02f26df43cc571bc9ed7b0c4d29224a3ec229529221725ef76d021c8326f",
    s: "abcdefghi",
  },
  {
    out: "72399361da6a7754fec986dca5b7cbaf1c810a28ded4abaf56b2106d06cb78b0",
    s: "abcdefghij",
  },
  {
    out: "a144061c271f152da4d151034508fed1c138b8c976339de229c3bb6d4bbb4fce",
    s: "Discard medicine more than two years old.",
  },
  {
    out: "6dae5caa713a10ad04b46028bf6dad68837c581616a1589a265a11288d4bb5c4",
    s: "He who has a shady past knows that nice guys finish last.",
  },
  {
    out: "ae7a702a9509039ddbf29f0765e70d0001177914b86459284dab8b348c2dce3f",
    s: "I wouldn't marry him with a ten foot pole.",
  },
  {
    out: "6748450b01c568586715291dfa3ee018da07d36bb7ea6f180c1af6270215c64f",
    s: "Free! Free!/A trip/to Mars/for 900/empty jars/Burma Shave",
  },
  {
    out: "14b82014ad2b11f661b5ae6a99b75105c2ffac278cd071cd6c05832793635774",
    s: "The days of the digital watch are numbered.  -Tom Stoppard",
  },
  {
    out: "7102cfd76e2e324889eece5d6c41921b1e142a4ac5a2692be78803097f6a48d8",
    s: "Nepal premier won't resign.",
  },
  {
    out: "23b1018cd81db1d67983c5f7417c44da9deb582459e378d7a068552ea649dc9f",
    s: "For every action there is an equal and opposite government program.",
  },
  {
    out: "8001f190dfb527261c4cfcab70c98e8097a7a1922129bc4096950e57c7999a5a",
    s: "His money is twice tainted: 'taint yours and 'taint mine.",
  },
  {
    out: "8c87deb65505c3993eb24b7a150c4155e82eee6960cf0c3a8114ff736d69cad5",
    s: "There is no reason for any individual to have a computer in their home. -Ken Olsen, 1977",
  },
  {
    out: "bfb0a67a19cdec3646498b2e0f751bddc41bba4b7f30081b0b932aad214d16d7",
    s: "It's a tiny change to the code and not completely disgusting. - Bob Manchek",
  },
  {
    out: "7f9a0b9bf56332e19f5a0ec1ad9c1425a153da1c624868fda44561d6b74daf36",
    s: "size:  a.out:  bad magic",
  },
  {
    out: "b13f81b8aad9e3666879af19886140904f7f429ef083286195982a7588858cfc",
    s: "The major problem is with sendmail.  -Mark Horton",
  },
  {
    out: "b26c38d61519e894480c70c8374ea35aa0ad05b2ae3d6674eec5f52a69305ed4",
    s: "Give me a rock, paper and scissors and I will move the world.  CCFestoon",
  },
  {
    out: "049d5e26d4f10222cd841a119e38bd8d2e0d1129728688449575d4ff42b842c1",
    s: "If the enemy is within range, then so are you.",
  },
  {
    out: "0e116838e3cc1c1a14cd045397e29b4d087aa11b0853fc69ec82e90330d60949",
    s: "It's well we cannot hear the screams/That we create in others' dreams.",
  },
  {
    out: "4f7d8eb5bcf11de2a56b971021a444aa4eafd6ecd0f307b5109e4e776cd0fe46",
    s: "You remind me of a TV show, but that's all right: I watch it anyway.",
  },
  {
    out: "61c0cc4c4bd8406d5120b3fb4ebc31ce87667c162f29468b3c779675a85aebce",
    s: "C is as portable as Stonehedge!!",
  },
  {
    out: "1fb2eb3688093c4a3f80cd87a5547e2ce940a4f923243a79a2a1e242220693ac",
    s: "Even if I could be Shakespeare, I think I should still choose to be Faraday. - A. Huxley",
  },
  {
    out: "395585ce30617b62c80b93e8208ce866d4edc811a177fdb4b82d3911d8696423",
    s: "The fugacity of a constituent in a mixture of gases at a given temperature is proportional to its mole fraction.  Lewis-Randall Rule",
  },
  {
    out: "4f9b189a13d030838269dce846b16a1ce9ce81fe63e65de2f636863336a98fe6",
    s: "How can you write a big system without C++?  -Paul Glick",
  },
]

test "check_sum works properly" {
  for tt in golden {
    let digest = @sha256.Digest::new()
    let bytes = @base64.str2bytes(tt.s)
    for b in bytes {
      digest.write(b)
    }
    let got = digest.check_sum()
    assert_eq!(got, tt.out)
  }
}
