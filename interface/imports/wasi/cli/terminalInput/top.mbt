// Generated by `wit-bindgen` 0.29.0. DO NOT EDIT!

///|
/// The input side of a terminal.
pub(all) type TerminalInput Int derive(Show, Eq)

///|
fn wasmImportResourceDropTerminalInput(resource : Int) = "wasi:cli/terminal-input@0.2.0" "[resource-drop]terminal-input"

///|
pub fn TerminalInput::drop(self : TerminalInput) -> Unit {
  wasmImportResourceDropTerminalInput(self._)
}
