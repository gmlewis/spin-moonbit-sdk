test "gen_hmac works on simple case" {
  let got = @sha256.gen_hmac(b"message-to-be-authenticated", b"key")
  let want = "zdsNsj9GnIvwcrIf2DcUm9as6at3HM7vFMnlF8yTKC4="
  assert_eq!(got, want)
}
