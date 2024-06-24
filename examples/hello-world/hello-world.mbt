fn init {
  @http.register(handle_hello_world)
}

fn handle_hello_world(_req : @http.Request) -> Result[@http.Response, String] {
  Ok(
    @http.Response::builder().status(200).header("content-type", "text/plain").body(
      "Hello, Fermyon from MoonBit SDK",
    ),
  )
}

pub fn fermyon_spin_inbound_http() -> Int {
  @http.fermyon_spin_inbound_http()
}
