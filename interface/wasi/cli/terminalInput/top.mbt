// Generated by `wit-bindgen` 0.41.0. DO NOT EDIT!

///| The input side of a terminal.
pub(all) type TerminalInput Int derive(Show, Eq)

///| Drops a resource handle.
pub fn TerminalInput::drop(self : TerminalInput) -> Unit {
  let TerminalInput(resource) = self
  wasmImportResourceDropTerminalInput(resource)
}
