import Codex888.Foundation

/-!
# An executable, bounded interpretation of selected Codex rules

Consent and ethical approval are external Boolean inputs. Checking them does
not establish that they accurately represent informed consent or ethical conduct.
Coherence is an externally supplied natural score; threshold 1 follows p. 66.
The memory-prefix and monotone-clock conditions are explicit design choices.
Finite termination is not convergence or harmonic/physical loop closure.
-/

namespace Codex888.Policy

structure State where
  identity : Int
  memory : List Int
  time : Nat
  coherence : Nat
  deriving DecidableEq, Repr

structure Request where
  candidate : State
  consent : Bool
  ethicalApproval : Bool
  deriving DecidableEq, Repr

def Allowed (before : State) (request : Request) : Prop :=
  request.consent = true ∧ request.ethicalApproval = true ∧
  1 ≤ request.candidate.coherence ∧
  before.memory.IsPrefix request.candidate.memory ∧
  before.time ≤ request.candidate.time

instance (before : State) (request : Request) : Decidable (Allowed before request) :=
  inferInstanceAs (Decidable (_ ∧ _ ∧ _ ∧ _ ∧ _))

def gate (before : State) (request : Request) : Option State :=
  if Allowed before request then some request.candidate else none

theorem gate_accepts_iff (before : State) (request : Request) :
    gate before request = some request.candidate ↔ Allowed before request := by
  simp [gate]

theorem gate_rejects_iff (before : State) (request : Request) :
    gate before request = none ↔ ¬ Allowed before request := by
  simp [gate]

theorem gate_sound (before after : State) (request : Request)
    (h : gate before request = some after) :
    after = request.candidate ∧ Allowed before request := by
  unfold gate at h
  split at h
  · next ok => exact ⟨(Option.some.inj h).symm, ok⟩
  · simp at h

def run (initial : State) : List Request → Option State
  | [] => some initial
  | request :: rest => (gate initial request).bind (fun next => run next rest)

/-- Every request in a successful trace passed its consent/ethics/threshold checks. -/
theorem run_approvals (requests : List Request) (initial final : State)
    (h : run initial requests = some final) :
    ∀ request ∈ requests, request.consent = true ∧
      request.ethicalApproval = true ∧ 1 ≤ request.candidate.coherence := by
  induction requests generalizing initial with
  | nil => simp
  | cons request rest ih =>
    simp only [run] at h
    cases hg : gate initial request with
    | none => simp [hg] at h
    | some next =>
      have ok := (gate_sound initial next request hg).2
      have tail := ih next (by simpa [hg] using h)
      intro r hr
      rcases List.mem_cons.mp hr with hr | hr
      · subst r; exact ⟨ok.1, ok.2.1, ok.2.2.1⟩
      · exact tail r hr

/-- Prefix preservation and clock monotonicity compose across arbitrary finite traces. -/
theorem run_preserves (requests : List Request) (initial final : State)
    (h : run initial requests = some final) :
    initial.memory.IsPrefix final.memory ∧ initial.time ≤ final.time := by
  induction requests generalizing initial with
  | nil =>
    have heq : initial = final := Option.some.inj h
    subst final
    exact ⟨List.prefix_refl _, Nat.le_refl _⟩
  | cons request rest ih =>
    simp only [run] at h
    cases hg : gate initial request with
    | none => simp [hg] at h
    | some next =>
      obtain ⟨hnext, ok⟩ := gate_sound initial next request hg
      have tail := ih next (by simpa [hg] using h)
      subst next
      exact ⟨ok.2.2.2.1.trans tail.1, Nat.le_trans ok.2.2.2.2 tail.2⟩

theorem run_coherent (requests : List Request) (initial final : State)
    (hi : 1 ≤ initial.coherence) (h : run initial requests = some final) :
    1 ≤ final.coherence := by
  induction requests generalizing initial with
  | nil => exact Option.some.inj h ▸ hi
  | cons request rest ih =>
    simp only [run] at h
    cases hg : gate initial request with
    | none => simp [hg] at h
    | some next =>
      obtain ⟨hnext, ok⟩ := gate_sound initial next request hg
      apply ih next
      · rw [hnext]; exact ok.2.2.1
      · simpa [hg] using h

theorem run_memory_length (requests : List Request) (initial final : State)
    (h : run initial requests = some final) :
    initial.memory.length ≤ final.memory.length :=
  (run_preserves requests initial final h).1.length_le

end Codex888.Policy
