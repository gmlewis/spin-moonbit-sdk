fn init {
  @http.register(handle_hello_world)
}

fn handle_hello_world(req : @http.Request) -> Result[@http.Response, String] {
  let url = req.header.get("spin-full-url")
  println("Handling request to \(url)")
  Ok(
    @http.Response::builder().status(200).header("content-type", "text/plain").body(
      "Hello, Fermyon from MoonBit SDK",
    ),
  )
}
