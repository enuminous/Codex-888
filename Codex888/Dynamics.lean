import Codex888.Foundation

/-!
# A discrete specialization of the identity update

Appendix V writes I(τ) + ∫₀ᵗ E(τ)M(τ)dτ. Here time is a finite number
of unit steps and the integral is explicitly replaced by an integer sum.
No continuum-limit equivalence or physical units are claimed.
-/

namespace Codex888.Discrete

def integrate (f : Nat → Int) : Nat → Int
  | 0 => 0
  | n + 1 => integrate f n + f n

theorem integrate_zero (n : Nat) : integrate (fun _ => 0) n = 0 := by
  induction n with
  | zero => rfl
  | succ n ih => simp [integrate, ih]

theorem integrate_add (f g : Nat → Int) (n : Nat) :
    integrate (fun k => f k + g k) n = integrate f n + integrate g n := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [integrate, ih]; omega

def transmuteIdentity (initial : Int) (ethics memory : Nat → Int) (steps : Nat) : Int :=
  initial + integrate (fun k => ethics k * memory k) steps

theorem transmute_zero_steps (initial : Int) (ethics memory : Nat → Int) :
    transmuteIdentity initial ethics memory 0 = initial := by
  simp [transmuteIdentity, integrate]

theorem transmute_without_ethics (initial : Int) (memory : Nat → Int) (steps : Nat) :
    transmuteIdentity initial (fun _ => 0) memory steps = initial := by
  simp [transmuteIdentity, integrate_zero]

theorem transmute_without_memory (initial : Int) (ethics : Nat → Int) (steps : Nat) :
    transmuteIdentity initial ethics (fun _ => 0) steps = initial := by
  simp [transmuteIdentity, integrate_zero]

theorem transmute_successor (initial : Int) (ethics memory : Nat → Int) (n : Nat) :
    transmuteIdentity initial ethics memory (n + 1) =
      transmuteIdentity initial ethics memory n + ethics n * memory n := by
  simp only [transmuteIdentity, integrate]
  omega

/-- Constant nonzero fields grow linearly: recursion alone does not imply stability. -/
theorem transmute_unit_fields (initial : Int) (n : Nat) :
    transmuteIdentity initial (fun _ => 1) (fun _ => 1) n = initial + (n : Int) := by
  induction n with
  | zero => simp [transmuteIdentity, integrate]
  | succ n ih => rw [transmute_successor, ih]; omega

/-- Prefix agreement suffices: later samples cannot change an earlier result. -/
theorem integrate_prefix (f g : Nat → Int) (n : Nat)
    (h : ∀ k, k < n → f k = g k) : integrate f n = integrate g n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [integrate]
    rw [ih (fun k hk => h k (by omega)), h n (by omega)]

/-- Stepwise evaluation gives exactly the declared accumulated identity update. -/
def evolve (ethics memory : Nat → Int) (initial : Int) : Nat → Int
  | 0 => initial
  | n + 1 => evolve ethics memory initial n + ethics n * memory n

theorem evolve_eq_transmute (ethics memory : Nat → Int) (initial : Int) (n : Nat) :
    evolve ethics memory initial n = transmuteIdentity initial ethics memory n := by
  induction n with
  | zero => simp [evolve, transmuteIdentity, integrate]
  | succ n ih => rw [evolve, ih, transmute_successor]

/-- The algebraic product from Appendix V, with an explicit supplied wave value. -/
def fullProduct (psi identity memory ethics consciousness wave : Int) : Int :=
  psi * identity * memory * ethics * consciousness * wave

theorem fullProduct_without_ethics (psi identity memory consciousness wave : Int) :
    fullProduct psi identity memory 0 consciousness wave = 0 := by
  simp [fullProduct]

end Codex888.Discrete
