// Generated by `wit-bindgen` 0.41.0. DO NOT EDIT!

///|
fn wasmImportResourceDropTcpSocket(resource : Int) = "wasi:sockets/tcp@0.2.0" "[resource-drop]tcp-socket"

///|
fn wasmImportMethodTcpSocketStartBind(
  p0 : Int,
  p1 : Int,
  p2 : Int,
  p3 : Int,
  p4 : Int,
  p5 : Int,
  p6 : Int,
  p7 : Int,
  p8 : Int,
  p9 : Int,
  p10 : Int,
  p11 : Int,
  p12 : Int,
  p13 : Int,
  p14 : Int
) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.start-bind"

///|
fn wasmImportMethodTcpSocketFinishBind(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.finish-bind"

///|
fn wasmImportMethodTcpSocketStartConnect(
  p0 : Int,
  p1 : Int,
  p2 : Int,
  p3 : Int,
  p4 : Int,
  p5 : Int,
  p6 : Int,
  p7 : Int,
  p8 : Int,
  p9 : Int,
  p10 : Int,
  p11 : Int,
  p12 : Int,
  p13 : Int,
  p14 : Int
) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.start-connect"

///|
fn wasmImportMethodTcpSocketFinishConnect(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.finish-connect"

///|
fn wasmImportMethodTcpSocketStartListen(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.start-listen"

///|
fn wasmImportMethodTcpSocketFinishListen(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.finish-listen"

///|
fn wasmImportMethodTcpSocketAccept(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.accept"

///|
fn wasmImportMethodTcpSocketLocalAddress(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.local-address"

///|
fn wasmImportMethodTcpSocketRemoteAddress(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.remote-address"

///|
fn wasmImportMethodTcpSocketIsListening(p0 : Int) -> Int = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.is-listening"

///|
fn wasmImportMethodTcpSocketAddressFamily(p0 : Int) -> Int = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.address-family"

///|
fn wasmImportMethodTcpSocketSetListenBacklogSize(
  p0 : Int,
  p1 : Int64,
  p2 : Int
) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-listen-backlog-size"

///|
fn wasmImportMethodTcpSocketKeepAliveEnabled(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.keep-alive-enabled"

///|
fn wasmImportMethodTcpSocketSetKeepAliveEnabled(p0 : Int, p1 : Int, p2 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-keep-alive-enabled"

///|
fn wasmImportMethodTcpSocketKeepAliveIdleTime(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.keep-alive-idle-time"

///|
fn wasmImportMethodTcpSocketSetKeepAliveIdleTime(
  p0 : Int,
  p1 : Int64,
  p2 : Int
) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-keep-alive-idle-time"

///|
fn wasmImportMethodTcpSocketKeepAliveInterval(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.keep-alive-interval"

///|
fn wasmImportMethodTcpSocketSetKeepAliveInterval(
  p0 : Int,
  p1 : Int64,
  p2 : Int
) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-keep-alive-interval"

///|
fn wasmImportMethodTcpSocketKeepAliveCount(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.keep-alive-count"

///|
fn wasmImportMethodTcpSocketSetKeepAliveCount(p0 : Int, p1 : Int, p2 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-keep-alive-count"

///|
fn wasmImportMethodTcpSocketHopLimit(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.hop-limit"

///|
fn wasmImportMethodTcpSocketSetHopLimit(p0 : Int, p1 : Int, p2 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-hop-limit"

///|
fn wasmImportMethodTcpSocketReceiveBufferSize(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.receive-buffer-size"

///|
fn wasmImportMethodTcpSocketSetReceiveBufferSize(
  p0 : Int,
  p1 : Int64,
  p2 : Int
) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-receive-buffer-size"

///|
fn wasmImportMethodTcpSocketSendBufferSize(p0 : Int, p1 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.send-buffer-size"

///|
fn wasmImportMethodTcpSocketSetSendBufferSize(p0 : Int, p1 : Int64, p2 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.set-send-buffer-size"

///|
fn wasmImportMethodTcpSocketSubscribe(p0 : Int) -> Int = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.subscribe"

///|
fn wasmImportMethodTcpSocketShutdown(p0 : Int, p1 : Int, p2 : Int) = "wasi:sockets/tcp@0.2.0" "[method]tcp-socket.shutdown"
