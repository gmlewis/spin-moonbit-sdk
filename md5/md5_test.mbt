/// This package is based on the Go implementation found here:
/// https://cs.opensource.google/go/go/+/refs/tags/go1.23.0:src/crypto/md5/md5_test.go
/// which has the copyright notice:
/// Copyright 2009 The Go Authors. All rights reserved.
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file.

struct MD5Test {
  out : String
  s : String
}

let golden : Array[MD5Test] = [
  { out: "d41d8cd98f00b204e9800998ecf8427e", s: "" },
  { out: "0cc175b9c0f1b6a831c399e269772661", s: "a" },
  { out: "187ef4436122d1cc2f40dc2b92f0eba0", s: "ab" },
  { out: "900150983cd24fb0d6963f7d28e17f72", s: "abc" },
  { out: "e2fc714c4727ee9395f324cd2e7f331f", s: "abcd" },
  { out: "ab56b4d92b40713acc5af89985d4b786", s: "abcde" },
  { out: "e80b5017098950fc58aad83c8c14978e", s: "abcdef" },
  { out: "7ac66c0f148de9519b8bd264312c4d64", s: "abcdefg" },
  { out: "e8dc4081b13434b45189a720b77b6818", s: "abcdefgh" },
  { out: "8aa99b1f439ff71293e95357bac6fd94", s: "abcdefghi" },
  { out: "a925576942e94b2ef57a066101b48876", s: "abcdefghij" },
  {
    out: "d747fc1719c7eacb84058196cfe56d57",
    s: "Discard medicine more than two years old.",
  },
  {
    out: "bff2dcb37ef3a44ba43ab144768ca837",
    s: "He who has a shady past knows that nice guys finish last.",
  },
  {
    out: "0441015ecb54a7342d017ed1bcfdbea5",
    s: "I wouldn't marry him with a ten foot pole.",
  },
  {
    out: "9e3cac8e9e9757a60c3ea391130d3689",
    s: "Free! Free!/A trip/to Mars/for 900/empty jars/Burma Shave",
  },
  {
    out: "a0f04459b031f916a59a35cc482dc039",
    s: "The days of the digital watch are numbered.  -Tom Stoppard",
  },
  { out: "e7a48e0fe884faf31475d2a04b1362cc", s: "Nepal premier won't resign." },
  {
    out: "637d2fe925c07c113800509964fb0e06",
    s: "For every action there is an equal and opposite government program.",
  },
  {
    out: "834a8d18d5c6562119cf4c7f5086cb71",
    s: "His money is twice tainted: 'taint yours and 'taint mine.",
  },
  {
    out: "de3a4d2fd6c73ec2db2abad23b444281",
    s: "There is no reason for any individual to have a computer in their home. -Ken Olsen, 1977",
  },
  {
    out: "acf203f997e2cf74ea3aff86985aefaf",
    s: "It's a tiny change to the code and not completely disgusting. - Bob Manchek",
  },
  { out: "e1c1384cb4d2221dfdd7c795a4222c9a", s: "size:  a.out:  bad magic" },
  {
    out: "c90f3ddecc54f34228c063d7525bf644",
    s: "The major problem is with sendmail.  -Mark Horton",
  },
  {
    out: "cdf7ab6c1fd49bd9933c43f3ea5af185",
    s: "Give me a rock, paper and scissors and I will move the world.  CCFestoon",
  },
  {
    out: "83bc85234942fc883c063cbd7f0ad5d0",
    s: "If the enemy is within range, then so are you.",
  },
  {
    out: "277cbe255686b48dd7e8f389394d9299",
    s: "It's well we cannot hear the screams/That we create in others' dreams.",
  },
  {
    out: "fd3fb0a7ffb8af16603f3d3af98f8e1f",
    s: "You remind me of a TV show, but that's all right: I watch it anyway.",
  },
  {
    out: "469b13a78ebf297ecda64d4723655154",
    s: "C is as portable as Stonehedge!!",
  },
  {
    out: "63eb3a2f466410104731c4b037600110",
    s: "Even if I could be Shakespeare, I think I should still choose to be Faraday. - A. Huxley",
  },
  {
    out: "72c2ed7592debca1c90fc0100f931a2f",
    s: "The fugacity of a constituent in a mixture of gases at a given temperature is proportional to its mole fraction.  Lewis-Randall Rule",
  },
  {
    out: "132f7619d33b523b1d9e5bd8e0928355",
    s: "How can you write a big system without C++?  -Paul Glick",
  },
]

test "check_sum works properly" {
  for tt in golden {
    let digest = @md5.Digest::new()
    let bytes = @base64.str2bytes(tt.s)
    for b in bytes {
      digest.write(b)
    }
    let got = digest.check_sum()
    assert_eq!(got, tt.out)
  }
}
