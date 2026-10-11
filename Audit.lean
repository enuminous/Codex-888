import Lean
import Codex888
import Codex888Tests

/-!
Audit every compiled Codex888 declaration, including private declarations and tests.
The only permitted foundational axioms are Lean's standard logical axioms.
This rejects placeholders, custom axioms, and native_decide dependencies.
-/

open Lean in
run_cmd do
  let env ← getEnv
  let allowed : Array Name := #[``propext, ``Classical.choice, ``Quot.sound]
  let mut count := 0
  let mut theoremCount := 0
  for (name, info) in env.constants.toList do
    let parts := name.toString.splitOn "."
    if parts.contains "Codex888" then
      count := count + 1
      if info matches .thmInfo _ then
        theoremCount := theoremCount + 1
      let axioms ← collectAxioms name
      for ax in axioms do
        unless allowed.contains ax do
          throwError "Unapproved axiom {ax} used by {name}"
  if count == 0 then
    throwError "Audit matched no Codex888 declarations"
  logInfo m!"Axiom audit passed: {count} declarations, {theoremCount} theorem declarations (including generated lemmas and examples)."
