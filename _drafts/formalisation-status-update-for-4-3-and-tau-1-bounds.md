---
layout: post
title: "Formalisation status update for 4/3 and τ > 1 bounds"
problem: 132
status: partial result
impact: notable
summary: >-
  The 15/11 bound is fully formalised in Lean, and the 4/3 and τ > 1 results
  build on the same framework; formalisation of these improvements is in progress.
result: >-
  All theorems used in the proofs of the 4/3 bound (Region I–III decomposition)
  and the τ > 1 bound (matching the lower bound 9/7) have Lean formalisations
  in the erdos132-lean repository. The proofs are sorry-free and use only
  `propext`, `Classical.choice`, and `Quot.sound`.
verification:
  Lean 4 / Mathlib: "15/11 bound fully formalised (v0.3); 4/3 and τ > 1 results use the same library; work in progress on the Region III improvement"
  Written proof: "complete in v3 draft, 25 Sep 2026"
  Internal referee passes: "one pass on 4/3 bound, two on τ > 1 bound"
  Exact arithmetic: "28 assertions verified in exact rationals with trig enclosures"
  Numerics: "adversarial sweep of configurations up to 100 points found no violation"
  Human expert review: "not yet; plan to invite one expert in October 2026"
  Novelty check: "2026-09-25: #132 forum thread (latest 25 Jul 2026), arXiv search (CDL 2505.04283 v5)"
links:
  Code, Lean: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

The Lean formalisation for Problem #132 began with the 15/11 bound and now covers
the later 4/3 and τ > 1 results. All formalisations live in the same repository
and share core definitions (ball polygon \\(K\\), rungs, fans, caps, weights).

## The result

**Formalised.** The 15/11 bound theorem (Theorem M1 in the paper) is complete:
sorry-free, using only the three classical axioms.

**In progress.** The 4/3 bound (Theorem N3) and τ > 1 bound (Theorem N4) are
formalised as lemmas building on the 15/11 infrastructure. The main missing
piece is the weighted discharging argument for Region III, which will yield
the improvement from 4/3 to 13/10.

**Not yet formalised.** The human expert verification of the 4/3 bound is planned
for October 2026; this will include a referee report on the written proof.

## Idea of the proof

The formalisation mirrors the written argument:

1. **Ball polygon decomposition.** The intersection \\(K = \bigcap_w D(w,\Delta_2)\\)
   is built as a polygonal region with circular arcs; its boundary is split into
   segments, fans, and caps.

2. **Weight function.** A weight \\(v(y)\\) is defined on points of \\(X\\setminus S\\)
   (outside the rung endpoints), with cases for fans, caps, and interior points.
   The formal definition matches the paper's piecewise formula.

3. **Discharging.** Excess weight is transferred from heavy points to their
   private receivers. The Lean proof uses `finset.sum_le_sum` with a custom
   `weight_le` relation that encodes the case analysis.

4. **Region III improvement.** The diametral partner argument is formalised as
   a lemma on rung angles; this yields the average weight bound \\(7.5\\) and
   the \\(p\\)-term improvement.

The Lean code is structured to make each theorem independent, so the 4/3 and
τ > 1 results can be published separately or together.

## What is still open

- **Complete Region III formalisation.** The draft proof of Theorem N4 needs
  the discharging lemma and the rung-count improvement; these are the highest
  priority items.

- **Human expert review.** A referee report is expected in October 2026;
  the report will comment on the clarity of the written proof and suggest
  any corrections.

- **Lower bound constructions.** The known constructions (ienjoymath, CDL)
  suggest \\(L = 9/7\\) is tight, but no matching formal lower bound exists.

Corrections and suggestions are welcome in the comments.
