# Formalization obligations — frozen first build

Target frozen on 2026-10-11: the 888-coordinate premise on manuscript p. 10,
the six symbolic operations on pp. 59–60, and a stated executable
interpretation of selected syntax/closure/policy rules. The complete book
is not declared formalized.

## Evidence status

| Obligation | Status | Evidence or next condition |
|---|---|---|
| Finite register count, cyclic arithmetic, signed tensor indexing | Demonstrated within the formal model when the Lean workflow passes | `Foundation.lean`, `Registers.lean`, `Symbolic.lean` |
| Symbolic fidelity of all six core operations | Supported by source-to-code inspection and structural checks | Compare each AST with pp. 59–60; no analytic semantics asserted. |
| Discrete recurrence and trace invariants | Demonstrated within the formal model when the Lean workflow passes | `Dynamics.lean`, `Policy.lean`, negative examples in `Codex888Tests.lean` |
| Continuous integrals and phase exponentials | Unresolved | Specify scalar domains, measures, integration bounds, regularity, units, and phase interpretation. |
| Discrete-to-continuous correspondence | Unresolved | Specify step size and quadrature, then prove an error bound under explicit regularity hypotheses. |
| The proposed 888 physical symmetries | Hypothesis/postulate | Supply the group, its action, physical observables, and evidence for the interpretation. |
| Automatic recursive stability | Rejected as an unconditional statement in the implemented recurrence | Unit ethics and memory give linear identity growth for arbitrary n. |
| Universal noncommutativity | Rejected as a universal rule | Cyclic shifts commute; test examples also show that other transformations can fail to commute. |
| Measurable coherence and harmonic closure | Unresolved | Supply Ξ as a computable quantity, its domain and units, and a relation between threshold and dynamical stability. |
| Consent and ethical correctness | Normative inputs, not empirical conclusions | The gate verifies flags. Authentication, informed consent, policy quality, and real-world conduct require independent evidence. |
| Identity preservation | Supported only in the narrow zero-contribution recurrence case | Accepted requests may change the identity integer; the policy checker proves memory-prefix preservation, not personal identity continuity. |
| Consciousness, physical forces, field coupling, resurrection | Hypothesis/postulate | No theorem here establishes these interpretations. Operational definitions and independent tests remain necessary. |

## Ambiguities retained rather than silently repaired

1. Appendix V begins with an incomplete Python/SymPy context: imports,
   `BASE`, `STATES`, several functions, and the lower-case `tau`/`t` symbols
   are not fully initialized in the printed excerpt (`Tau` is assigned).
   The Lean AST supplies explicit syntax constructors; it is not advertised
   as a verified translation of a runnable Python package.
2. The expression called `recursive_rotation` returns a scalar complex
   exponential. It does not specify an 888-dimensional rotation matrix or
   its action on a vector. The finite `rotate` model is documented separately.
3. `spell_of_unity()` integrates a **sum of four signals**, divided by 888,
   while Rule 5 speaks of unity as a product. Both statements remain visible;
   no equivalence between them is assumed.
4. The eight-field conceptual stack and the six named signals of Appendix V
   are separate types. No unsupported identification between them is added.
5. `E(i-j)` needs signed arguments, and `Psi(i+j)` can exceed 887.
   Wrapping either argument modulo 888 would alter the printed operation.
6. Finite program termination, memory preservation, and a supplied score ≥1
   do not establish physical loop closure, bounded trajectories, or convergence.
7. The grammar's four closure words are not a parser specification. A full
   parser, type checker, and soundness theorem for the printed language remain
   additional work.

## Anti-circularity and reproducibility

- The gate checks explicit data and flags. It does not infer their truth from
  a successful gate result or identify syntactic field occurrence with ethics.
- The preservation theorem quantifies over arbitrary finite request lists.
  It is derived from actual checks rather than assuming preservation as an
  axiom. The coherence threshold is fixed at 1 before tests.
- Regression examples include accepted traces, missing approvals, zero
  coherence, deleted/reordered memory, reversed time, and late trace failure.
- The axiom audit traverses dependencies of project declarations and rejects
  proof placeholders, custom axioms, and native-evaluation proof dependencies.
- A green compiler/axiom audit establishes formal checking. It is not an
  independent experiment, a full Zoo pass, or a Lean-independent proof check.
- No named Zoo animal is redefined or claimed to have been run here. The
  EFMW Zoo discipline supplies the explicit obligations and evidence boundary.

## Minimal next mathematical extension

Freeze a real-valued interpretation of the identity integral, a uniform
step size h, and a regularity bound for `E(t)M(t)`. Then prove a quantitative
quadrature bound between the discrete recurrence and that integral. Success
requires the stated error bound for every admissible input and time horizon;
failure includes a counterexample, a missing regularity hypothesis, or any
placeholder/custom axiom. This would extend analytic coverage without
asserting a physical interpretation.
