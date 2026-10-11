import Codex888

def main : IO Unit := do
  let initial : Codex888.Policy.State := ⟨7, [10], 0, 1⟩
  let next : Codex888.Policy.State := ⟨13, [10, 20], 1, 1⟩
  let approved : Codex888.Policy.Request := ⟨next, true, true⟩
  IO.println "Codex 888 — finite symbolic core"
  IO.println s!"Base: {Codex888.base}; rank-3 lattice cells: {Codex888.base ^ 3}"
  IO.println s!"Phase 887 + 1: {(Codex888.rotate 1 ⟨887, by decide⟩).val}"
  IO.println s!"Signed tensor argument E(0-1): {Codex888.Symbolic.tensorEthicsArgument ⟨0, by decide⟩ ⟨1, by decide⟩}"
  IO.println s!"Discrete identity, I=10, E=2, M(k)=k+1, 3 steps: {Codex888.Discrete.transmuteIdentity 10 (fun _ => 2) (fun n => (n : Int) + 1) 3}"
  IO.println s!"Approved request: {repr (Codex888.Policy.gate initial approved)}"
  IO.println s!"No consent: {repr (Codex888.Policy.gate initial { approved with consent := false })}"
  IO.println "Scope: formal software properties; analytic and physical interpretations remain open."
