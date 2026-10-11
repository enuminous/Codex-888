import Mathlib

/-!
# The precisely-statable mathematics behind the Codex 888 "888-base" architecture

The Codex 888 companion repository describes an "888-base, 888-state" architecture with
888 base states, 888 positional axes and 888 rotational symmetries, and an address space of
`888 ^ 888`.  The repository contains no formal theorems or axioms; this file formalizes the
parts of that description that have a standard mathematical / quantum-information meaning:

* the combinatorics of the address space,
* the Hilbert space of a register of 888-level quantum systems (qudits),
* the 888 "rotational symmetries" as the cyclic group of 888-th roots of unity,
* the generalized Pauli (Weyl–Heisenberg clock and shift) operators on an `n`-level system,
  which realise those rotations as quantum gates, and
* the unit modulus of the phase factor `exp (i S / Ξ)` in the Codex's path-integral formula.
-/

open Complex

namespace Codex888

/-! ## The number 888 and the address space -/

theorem factorization_888 : (888 : ℕ) = 2 ^ 3 * 3 * 37 := by norm_num

/-- Assigning one of 888 base states to each of 888 positional axes gives `888 ^ 888`
configurations: the Codex's "address space". -/
theorem address_space_card : Fintype.card (Fin 888 → Fin 888) = 888 ^ 888 := by
  simp only [Fintype.card_fun, Fintype.card_fin]

/-- The address space `888 ^ 888` is a 2619-digit decimal number. -/
theorem address_space_decimal_digits : (Nat.digits 10 (888 ^ 888)).length = 2619 := by
  native_decide

/-- `2 ^ 8697 < 888 ^ 888 ≤ 2 ^ 8698`: the address space carries between 8697 and 8698 bits,
so it would take 8698 qubits to index it. -/
theorem address_space_bits : 2 ^ 8697 < 888 ^ 888 ∧ 888 ^ 888 ≤ 2 ^ 8698 := by
  constructor <;> native_decide

/-! ## Registers of 888-level qudits -/

/-- The state space of a register of `m` qudits with `d` levels each, written in the
computational basis indexed by the configurations `Fin m → Fin d`, has complex dimension
`d ^ m`. -/
theorem qudit_register_finrank (d m : ℕ) :
    Module.finrank ℂ ((Fin m → Fin d) → ℂ) = d ^ m := by
  simp [Module.finrank_fintype_fun_eq_card]

/-- In particular, 888 qudits with 888 levels each span a Hilbert space of dimension
`888 ^ 888`. -/
theorem codex_register_finrank :
    Module.finrank ℂ ((Fin 888 → Fin 888) → ℂ) = 888 ^ 888 :=
  qudit_register_finrank 888 888

/-! ## The 888 rotational symmetries -/

/-- There are exactly 888 complex 888-th roots of unity ("rotational symmetries"). -/
theorem rotational_symmetries_card : Fintype.card (rootsOfUnity 888 ℂ) = 888 :=
  Complex.card_rootsOfUnity 888

/-- They form a cyclic group. -/
theorem rotational_symmetries_cyclic : IsCyclic (rootsOfUnity 888 ℂ) := inferInstance

/-! ## Generalized Pauli (clock and shift) operators on an `n`-level system -/

variable {n : ℕ} [NeZero n]

/-- The primitive `n`-th root of unity `ω = exp (2πi / n)`. -/
noncomputable def omega (n : ℕ) : ℂ := Complex.exp (2 * Real.pi * Complex.I / n)

/-- The shift operator `X |j⟩ = |j + 1⟩`, acting on wave functions `ψ : ZMod n → ℂ`. -/
def shift (ψ : ZMod n → ℂ) : ZMod n → ℂ := fun j => ψ (j - 1)

/-- The clock operator `Z |j⟩ = ω ^ j |j⟩`. -/
noncomputable def clock (ψ : ZMod n → ℂ) : ZMod n → ℂ := fun j => omega n ^ j.val * ψ j

lemma omega_isPrimitiveRoot : IsPrimitiveRoot (omega n) n :=
  Complex.isPrimitiveRoot_exp n (NeZero.ne n)

lemma omega_pow_n : omega n ^ n = 1 := (omega_isPrimitiveRoot (n := n)).pow_eq_one

lemma omega_pow_mod (k : ℕ) : omega n ^ (k % n) = omega n ^ k := by
  conv_rhs => rw [← Nat.mod_add_div k n, pow_add, pow_mul, omega_pow_n, one_pow, mul_one]

lemma norm_omega : ‖omega n‖ = 1 :=
  (omega_isPrimitiveRoot (n := n)).norm'_eq_one (NeZero.ne n)

omit [NeZero n] in
lemma iterate_shift (k : ℕ) (ψ : ZMod n → ℂ) (j : ZMod n) :
    (shift^[k] ψ) j = ψ (j - k) := by
  induction k generalizing ψ with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply, ih]
    simp only [shift, Nat.cast_succ]
    congr 1; ring

omit [NeZero n] in
lemma iterate_clock (k : ℕ) (ψ : ZMod n → ℂ) (j : ZMod n) :
    (clock^[k] ψ) j = omega n ^ (k * j.val) * ψ j := by
  induction k generalizing ψ with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply, ih]
    simp only [clock]
    rw [Nat.succ_mul, pow_add]; ring

omit [NeZero n] in
/-- Applying the shift `n` times is the identity: `X ^ n = 1`. -/
theorem shift_pow_n (ψ : ZMod n → ℂ) : shift^[n] ψ = ψ := by
  funext j; rw [iterate_shift]; simp

/-- Applying the clock `n` times is the identity: `Z ^ n = 1`. -/
theorem clock_pow_n (ψ : ZMod n → ℂ) : clock^[n] ψ = ψ := by
  funext j; rw [iterate_clock, pow_mul, omega_pow_n, one_pow, one_mul]

/-- The Weyl commutation relation `Z X = ω X Z`. -/
theorem clock_shift_commutation (ψ : ZMod n → ℂ) :
    clock (shift ψ) = omega n • shift (clock ψ) := by
  funext j
  simp only [clock, shift, Pi.smul_apply, smul_eq_mul]
  have hj : j = (j - 1) + 1 := by ring
  have key : omega n ^ j.val = omega n * omega n ^ (j - 1).val := by
    conv_lhs => rw [hj, ZMod.val_add, omega_pow_mod, pow_add, ZMod.val_one_eq_one_mod,
      omega_pow_mod, pow_one]
    ring
  rw [key]; ring

/-- The shift operator is unitary (it preserves the total probability `∑ |ψ j|²`). -/
theorem shift_norm_sq (ψ : ZMod n → ℂ) :
    ∑ j, ‖shift ψ j‖ ^ 2 = ∑ j, ‖ψ j‖ ^ 2 := by
  simp only [shift]
  exact Fintype.sum_equiv (Equiv.subRight 1) _ _ (fun _ => rfl)

/-- The clock operator is unitary (it preserves the total probability `∑ |ψ j|²`). -/
theorem clock_norm_sq (ψ : ZMod n → ℂ) :
    ∑ j, ‖clock ψ j‖ ^ 2 = ∑ j, ‖ψ j‖ ^ 2 := by
  simp [clock, norm_omega]

/-- For the Codex's 888-level system: `X ^ 888 = Z ^ 888 = 1` and `Z X = ω X Z` with
`ω = exp (2πi / 888)`. -/
theorem codex_weyl_relations (ψ : ZMod 888 → ℂ) :
    shift^[888] ψ = ψ ∧ clock^[888] ψ = ψ ∧
      clock (shift ψ) = omega 888 • shift (clock ψ) :=
  ⟨shift_pow_n ψ, clock_pow_n ψ, clock_shift_commutation ψ⟩

/-! ## The path-integral phase factor -/

/-- In the Codex's path-integral expression `∫ Ψₑ ℜₑ Φₘ e^(i 𝓢ᵣ / Ξ) Dx`, the phase factor has
modulus one whenever the action `S` and the coherence parameter `Ξ` are real. -/
theorem path_phase_norm (S Ξ : ℝ) : ‖Complex.exp (Complex.I * (S / Ξ : ℝ))‖ = 1 := by
  rw [mul_comm]; exact Complex.norm_exp_ofReal_mul_I _

end Codex888
