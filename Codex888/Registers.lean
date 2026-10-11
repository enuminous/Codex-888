import Codex888.Foundation

/-!
# The combinatorial address count

An n-position register is a tuple of n independent 888-state coordinates.
The finite enumeration is a proof device: never evaluate `registers 888`.
Completeness, absence of duplicates, and its length establish the exact count.
This is a classical symbolic address count, not a claim about quantum capacity.
-/

namespace Codex888

def Register : Nat → Type
  | 0 => Unit
  | n + 1 => Phase × Register n

def registers : (n : Nat) → List (Register n)
  | 0 => [()]
  | n + 1 => (List.finRange base).flatMap fun d => (registers n).map fun r => (d, r)

theorem registers_length (n : Nat) : (registers n).length = base ^ n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp [registers, List.length_flatMap, ih, Nat.pow_succ, Nat.mul_comm]

theorem registers_complete (n : Nat) (r : Register n) : r ∈ registers n := by
  induction n with
  | zero => cases r; simp [registers]
  | succ n ih =>
    rcases r with ⟨d, rest⟩
    apply List.mem_flatMap.mpr
    refine ⟨d, ?_, List.mem_map.mpr ⟨rest, ih rest, rfl⟩⟩
    exact List.mem_ofFn.mpr ⟨d, rfl⟩

private theorem phases_nodup : (List.finRange base).Nodup := by
  apply List.pairwise_iff_getElem.mpr
  intro i j hi hj hij heq
  have hv : i = j := congrArg Fin.val heq
  omega

theorem registers_nodup (n : Nat) : (registers n).Nodup := by
  induction n with
  | zero => simp [registers]
  | succ n ih =>
    apply List.pairwise_flatMap.mpr
    constructor
    · intro d _
      apply List.pairwise_map.mpr
      exact ih.imp fun hne heq => hne (congrArg Prod.snd heq)
    · apply phases_nodup.imp
      intro a b hab x hx y hy heq
      obtain ⟨u, _, rfl⟩ := List.mem_map.mp hx
      obtain ⟨v, _, rfl⟩ := List.mem_map.mp hy
      exact hab (congrArg Prod.fst heq)

/-- Precisely 888^888 distinct, exhaustively enumerated symbolic registers. -/
theorem address_count :
    (registers base).length = base ^ base ∧ (registers base).Nodup ∧
      (∀ r : Register base, r ∈ registers base) :=
  ⟨registers_length base, registers_nodup base, registers_complete base⟩

end Codex888
