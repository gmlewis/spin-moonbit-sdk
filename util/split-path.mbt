/// `split_path` splits an incoming request into its method and path parts by splitting on "/".
pub fn split_path(
  request : @types.IncomingRequest
) -> (@types.Method, Array[String]) {
  split_method_and_path(request.method(), request.path_with_query())
}

fn split_method_and_path(
  method : @types.Method,
  path : String?
) -> (@types.Method, Array[String]) {
  let result = match path {
    Some(s) =>
      if s.length() > 1 {
        s.substring(start=1).split("/").collect()
      } else {
        []
      }
    _ => []
  }
  (method, result)
}

test "split_path random cases" {
  // Mock request with random path "/random/123/path"
  inspect!(
    split_method_and_path(@types.Get, Some("/random/123/path")),
    content="(Get, [\"random\", \"123\", \"path\"])",
  )

  // Mock request with random path "/a/b/c/d/e/f"
  inspect!(
    split_method_and_path(@types.Post, Some("/a/b/c/d/e/f")),
    content="(Post, [\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"])",
  )

  // Mock request with random path "/long/path/with/many/segments"
  inspect!(
    split_method_and_path(@types.Get, Some("/long/path/with/many/segments")),
    content="(Get, [\"long\", \"path\", \"with\", \"many\", \"segments\"])",
  )

  // Mock request with random path "/single"
  inspect!(
    split_method_and_path(@types.Get, Some("/single")),
    content="(Get, [\"single\"])",
  )
}

test "split_path edge cases" {
  // Mock request with no path
  inspect!(split_method_and_path(@types.Get, None), content="(Get, [])")

  // @types.Get request with empty path
  inspect!(split_method_and_path(@types.Get, Some("")), content="(Get, [])")

  // @types.Get request with path "/"
  inspect!(split_method_and_path(@types.Get, Some("/")), content="(Get, [])")
}

test "split_path basic functionality" {
  // Mock request with GET method and path "/path/to/resource"
  inspect!(
    split_method_and_path(@types.Get, Some("/path/to/resource")),
    content="(Get, [\"path\", \"to\", \"resource\"])",
  )

  // Mock request with GET method and path with trailing slash "/path/to/resource/"
  inspect!(
    split_method_and_path(@types.Get, Some("/path/to/resource/")),
    content="(Get, [\"path\", \"to\", \"resource\"])",
  )

  // Mock request with POST method and path "/another/path"
  inspect!(
    split_method_and_path(@types.Post, Some("/another/path")),
    content="(Post, [\"another\", \"path\"])",
  )
}
