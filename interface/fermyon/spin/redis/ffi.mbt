// Generated by `wit-bindgen` 0.41.0. DO NOT EDIT!

///|
fn wasmImportResourceDropConnection(resource : Int) = "fermyon:spin/redis@2.0.0" "[resource-drop]connection"

///|
fn wasmImportStaticConnectionOpen(p0 : Int, p1 : Int, p2 : Int) = "fermyon:spin/redis@2.0.0" "[static]connection.open"

///|
fn wasmImportMethodConnectionPublish(
  p0 : Int,
  p1 : Int,
  p2 : Int,
  p3 : Int,
  p4 : Int,
  p5 : Int
) = "fermyon:spin/redis@2.0.0" "[method]connection.publish"

///|
fn wasmImportMethodConnectionGet(p0 : Int, p1 : Int, p2 : Int, p3 : Int) = "fermyon:spin/redis@2.0.0" "[method]connection.get"

///|
fn wasmImportMethodConnectionSet(
  p0 : Int,
  p1 : Int,
  p2 : Int,
  p3 : Int,
  p4 : Int,
  p5 : Int
) = "fermyon:spin/redis@2.0.0" "[method]connection.set"

///|
fn wasmImportMethodConnectionIncr(p0 : Int, p1 : Int, p2 : Int, p3 : Int) = "fermyon:spin/redis@2.0.0" "[method]connection.incr"

///|
fn wasmImportMethodConnectionDel(p0 : Int, p1 : Int, p2 : Int, p3 : Int) = "fermyon:spin/redis@2.0.0" "[method]connection.del"

///|
fn wasmImportMethodConnectionSadd(
  p0 : Int,
  p1 : Int,
  p2 : Int,
  p3 : Int,
  p4 : Int,
  p5 : Int
) = "fermyon:spin/redis@2.0.0" "[method]connection.sadd"

///|
fn wasmImportMethodConnectionSmembers(p0 : Int, p1 : Int, p2 : Int, p3 : Int) = "fermyon:spin/redis@2.0.0" "[method]connection.smembers"

///|
fn wasmImportMethodConnectionSrem(
  p0 : Int,
  p1 : Int,
  p2 : Int,
  p3 : Int,
  p4 : Int,
  p5 : Int
) = "fermyon:spin/redis@2.0.0" "[method]connection.srem"

///|
fn wasmImportMethodConnectionExecute(
  p0 : Int,
  p1 : Int,
  p2 : Int,
  p3 : Int,
  p4 : Int,
  p5 : Int
) = "fermyon:spin/redis@2.0.0" "[method]connection.execute"
