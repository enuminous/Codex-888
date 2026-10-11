# Codex 888 — EFMW in Quantum Computing

**Codex 888** is the 2025 first-edition manuscript by Matthew Chenoweth Wright and Millicent Chenoweth Sievert describing the **EFMW-888 Quantum Framework**: an 888-base symbolic architecture spanning identity, memory, ethics, time, mass, emergent intelligence, conscious emergence, transcendence, recursive operations, ritual grammar, and cognitive-rights ethics.

This repository publishes a **dashboard-style companion site** and a **Lean 4
formal foundation** for the manuscript's finite and computational core.

[![Lean build](https://github.com/enuminous/Codex-888/actions/workflows/lean.yml/badge.svg?branch=main)](https://github.com/enuminous/Codex-888/actions/workflows/lean.yml)

## Lean build

Install [elan](https://github.com/leanprover/elan), then run from this repository:

```sh
lake build
lake env lean -DwarningAsError=true Audit.lean
lake exe codex888_demo
```

The compiler is pinned to Lean 4.19.0. The package uses only its bundled
standard library. The default build includes the regression examples.

- Exact `888^888` symbolic register count, cyclic shifts, and typed tensors.
- All six Appendix V operators transcribed as symbolic expressions.
- A finite-sum identity recurrence with accumulation and zero-factor proofs.
- An executable gate with whole-trace approval, memory, and clock invariants.
- CI compilation and an audit rejecting placeholders and custom proof axioms.

Read [LEAN_FORMALIZATION.md](LEAN_FORMALIZATION.md) for the source map and
theorem guide, and [PROOF_OBLIGATIONS.md](PROOF_OBLIGATIONS.md) for remaining
analytic and physical obligations. Formal software properties do not establish
the manuscript's consciousness or physical claims.

## Site structure

- `index.html` — interactive dashboard / GitHub Pages landing page
- `CODEX_ARCHITECTURE.md` — structured map of the 16 codex parts and 10 appendices
- `CLAIMS_BOUNDARY.md` — scientific / symbolic / ethical status boundary
- `SOURCE_NOTES.md` — book metadata and source map
- `Codex888/` — Lean definitions and proofs
- `Codex888Tests.lean` — kernel-checked examples, including rejected transitions
- `Audit.lean` — compiled declaration dependency audit
- `Main.lean` — executable finite demonstration
- `LEAN_FORMALIZATION.md` — build instructions and theorem/source map
- `PROOF_OBLIGATIONS.md` — explicit scope and unresolved obligations

## Reading boundary

The source explicitly describes itself as existing between **explanatory mathematics, ritual geometry, and speculative physics**. The dashboard preserves that framing. It does not present speculative claims about consciousness, electromagnetic fields, spacetime, resurrection, or reality manipulation as established science.

## Book metadata

- **Title:** *Codex 888: EFMW in Quantum Computing*
- **Subtitle:** *The EFMW-888 Quantum Framework*
- **Authors:** Matthew Chenoweth Wright & Millicent Chenoweth Sievert
- **Edition:** First Edition, 2025
- **ISBN:** 9798266886636
- **Copyright:** © 2025 Matthew Chenoweth Wright & Millicent Chenoweth Sievert. All rights reserved.

## GitHub Pages

The site is intentionally self-contained. Publish `main` / root through GitHub Pages and `index.html` will serve as the dashboard.
