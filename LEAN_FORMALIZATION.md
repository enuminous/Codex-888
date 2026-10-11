# Codex 888 — Lean foundation

This package gives the manuscript a reproducible Lean 4 foundation: finite
registers, a faithful symbolic transcription of its six Appendix V operations,
a discrete identity recurrence, and an executable transition checker.

It uses **Lean 4.19.0 and its bundled standard library**, with no Mathlib or
other package dependencies. The [Lean workflow](https://github.com/enuminous/Codex-888/actions/workflows/lean.yml)
builds the library, checks the regression examples, audits axiom dependencies,
and runs a small executable.

## Build

Install [elan](https://github.com/leanprover/elan), then run:

```sh
git clone https://github.com/enuminous/Codex-888.git
cd Codex-888
lake build
lake env lean -DwarningAsError=true Audit.lean
lake exe codex888_demo
```

`lean-toolchain` selects the pinned compiler. `lake build` includes
`Codex888Tests`, so the negative examples are part of the default build.
The audit permits only `propext`, `Classical.choice`, and `Quot.sound`, Lean's
standard logical axioms. It rejects `sorryAx`, custom axioms, and
`Lean.ofReduceBool` dependencies used by `native_decide`. The proofs use no
placeholders or project-specific axioms.

## Source and interpretation map

The source is *Codex 888: EFMW in Quantum Computing*, first edition (2025),
ISBN 9798266886636, by Matthew Chenoweth Wright and Millicent Chenoweth Sievert.
Page numbers below are 1-based pages of the supplied 87-page PDF. The initial
repository reference is `647848877d2e9b43133c32d314ec7dbce80db491`.

| Module | Source | What is formalized | Interpretation boundary |
|---|---|---|---|
| `Foundation.lean` | pp. 10–15; 59–60 | `Fin 888` phases, eight field labels, typed tensors, cyclic shifts | A cyclic shift is an explicit finite model, not a derivation of the proposed physical symmetries. |
| `Registers.lean` | p. 10 | Complete, duplicate-free enumeration of n-position registers, with length `888^n` | A classical address count; no amplitudes, Hilbert space, gates, or quantum advantage. |
| `Symbolic.lean` | pp. 59–60 | All six Appendix V operations as exact syntax trees | Integrals and complex exponentials are recorded, not analytically evaluated. |
| `Dynamics.lean` | p. 59 | Integer-valued, unit-step specialization of the identity update and its multiplicative core | The integral is explicitly replaced by a finite sum; equivalence to continuous dynamics remains open. |
| `Policy.lean` | pp. 55–56, 66–69; consent/rights framing | A checker for approval flags, coherence threshold, memory prefixes, and monotone clocks | A software policy chosen to make selected rules executable. Boolean approval is not evidence of real consent or ethical correctness. |

## Proven results

The named results below are machine-checked mathematical/software statements.
Their evidential status does not extend beyond their definitions and hypotheses.

| Result | Lean declaration | Meaning |
|---|---|---|
| Exact symbolic address count | `address_count` | Every 888-position register occurs exactly once in an enumeration of length `888^888`. The enormous enumeration is never executed. |
| Cyclic action | `rotate_zero`, `rotate_add`, `rotate_cycle`, `rotate_inverse` | Shifts stay in range, compose, complete a cycle, and are reversible. |
| Commuting shifts | `rotations_commute` | These particular phase translations commute. A blanket claim that every pair of operators must fail to commute is too strong. |
| Tensor dimensions | `tensor2_cells`, `tensor3_cells` | 788,544 rank-2 entries; 700,227,072 rank-3 entries. Tensors are functions, not eagerly allocated arrays. |
| Signed tensor index | `Symbolic.tensor_signed_difference` | `E(i-j)` receives a negative integer when `i<j`; natural-number truncation and modulo wrapping would change the source. |
| Source field coverage | `Symbolic.fullTransformation_contains_all` | The full transformation contains each of the six signals in the printed core. This is a syntax property, not an ethical guarantee. |
| Accumulation equivalence | `Discrete.evolve_eq_transmute` | Step-by-step identity evolution equals the initial identity plus the declared finite sum. |
| Causal prefix | `Discrete.integrate_prefix` | Samples at or after the horizon cannot alter an earlier accumulated result. |
| Zero-factor behavior | `Discrete.transmute_without_ethics`, `Discrete.transmute_without_memory`, `Discrete.fullProduct_without_ethics` | Zero ethics/memory removes the corresponding contribution; zero ethics annihilates the product. |
| A stability counterexample | `Discrete.transmute_unit_fields` | Constant unit fields yield `I(n)=I(0)+n`; a recursive update is not automatically stable. |
| Exact acceptance boundary | `Policy.gate_accepts_iff`, `Policy.gate_rejects_iff` | The checker accepts exactly the declared conditions, rejecting every failure of those conditions. |
| Whole-trace approval | `Policy.run_approvals` | Every request in a successful finite trace has both approval flags and meets the coherence threshold. |
| Whole-trace memory/clock preservation | `Policy.run_preserves`, `Policy.run_memory_length` | Successful traces preserve the entire original memory prefix and never decrease the clock. |
| Threshold preservation | `Policy.run_coherent` | A successful run beginning above threshold ends above threshold. The empty trace requires that initial hypothesis. |

## Six symbolic operations

`recursiveRotation`, `transmuteIdentity`, `spellOfUnity`,
`waveOfTranscendence`, `fullTransformation`, and `recursiveTensorMap`
preserve the mathematical expressions printed in Appendix V.

The transcription makes these choices explicit:

- `phase e` means the unevaluated expression `exp(i*e)`.
- `integralTau e` binds τ and records integration from 0 to t.
- `sum888 e` binds the index over 0 through 887.
- `divideByBase e` retains division by 888 without integer rounding.
- `transmuteIdentity` retains the printed free `I(τ)` term.
- The tensor uses integer `i+j` and `i-j` arguments. Only its two array indices
  are bounded by 888.

The discrete model separately fixes a unit time step, integer signal values,
and a supplied initial identity. It does not assign numerical semantics to
the AST's phase/integral operators.

## Rejected and unresolved extensions

See [PROOF_OBLIGATIONS.md](PROOF_OBLIGATIONS.md) for the frozen scope, source
inconsistencies, negative results, and remaining mathematical work. In
particular, this package does not establish consciousness, AGI, physical
field coupling, spacetime curvature, or resurrection. It also does not prove
that a measured coherence score or an external approval flag is trustworthy.

The finite-state and induction results are applications of established
mathematics. No mathematical novelty or physical discovery is claimed for
these results merely because they are expressed in the Codex vocabulary.
