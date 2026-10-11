import Codex888

/-! Kernel-checked examples, including rejected requests and source edge cases. -/
namespace Codex888.Tests

example : (rotate 1 ⟨887, by decide⟩).val = 0 := by decide
example : (rotate 1777 ⟨887, by decide⟩).val = 0 := by decide
example : Symbolic.tensorEthicsArgument ⟨0, by decide⟩ ⟨1, by decide⟩ = -1 := by decide
example : Symbolic.spellOfUnity.contains .psi = false := by decide
example : Symbolic.spellOfUnity.contains .ethics = true := by decide
example : Discrete.transmuteIdentity 10 (fun _ => 2) (fun n => (n : Int) + 1) 3 = 22 := by decide
example : Discrete.transmuteIdentity 10 (fun _ => 0) (fun n => (n : Int) + 1) 3 = 10 := by decide
example : Discrete.fullProduct 2 3 4 0 5 6 = 0 := by decide

/-- Operator order can matter; that is weaker than saying every pair fails to commute. -/
example : (fun x : Int => 2 * x) ((fun x => x + 1) 0) ≠
    (fun x : Int => x + 1) ((fun x => 2 * x) 0) := by decide

open Policy

def initial : State := ⟨7, [10], 0, 1⟩
def next : State := ⟨13, [10, 20], 1, 1⟩
def final : State := ⟨18, [10, 20, 30], 2, 2⟩
def accepted : Request := ⟨next, true, true⟩

example : gate initial accepted = some next := by decide
example : gate initial { accepted with consent := false } = none := by decide
example : gate initial { accepted with ethicalApproval := false } = none := by decide
example : gate initial { accepted with candidate := { next with coherence := 0 } } = none := by decide
example : gate initial { accepted with candidate := { next with memory := [] } } = none := by decide
example : gate initial { accepted with candidate := { next with memory := [20, 10] } } = none := by decide
example : gate { initial with time := 2 } accepted = none := by decide
example : run initial [] = some initial := by decide
example : run initial [accepted, ⟨final, true, true⟩] = some final := by decide
example : run initial [accepted, ⟨final, false, true⟩] = none := by decide
example : run initial [accepted, ⟨{ final with memory := [30] }, true, true⟩] = none := by decide

/-- A high score cannot replace consent. -/
example : gate initial ⟨{ next with coherence := 888 }, false, true⟩ = none := by decide

end Codex888.Tests
