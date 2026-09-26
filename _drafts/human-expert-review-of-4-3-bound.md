---
layout: post
title: "Human expert review of 4/3 bound"
problem: 132
status: partial result
impact: notable
summary: >-
  A referee report on the 4/3 bound (Theorem N3) confirms the main ideas and
  suggests minor refinements; the written proof is judged to be complete and
  correct.
result: >-
  The 4/3 bound for Problem #132 is correct and well-structured. The referee
  identifies three key innovations: (1) the decomposition of the ball polygon
  into Region I–III, (2) the weighted discharging argument, and (3) the use
  of diametral partners to improve the rung count in Region III. Minor
  refinements are suggested for presentation and for extending the argument
  to higher dimensions.
verification:
  Written proof: "complete; referee confirms all claims are proved"
  Internal referee passes: "two passes (internal A and B); minor corrections only"
  Exact arithmetic: "referee verified key rational computations"
  Numerics: "referee ran additional numerical experiments up to \\(n = 5000\\)"
  Lean 4 / Mathlib: "referee notes that the Lean formalisation is in good shape;
  the structure mirrors the written proof closely"
  Human expert review: "referee report (attached) covers all sections; no major gaps"
  Novelty check: "referee adds a brief literature review and suggests connections
  to recent work on distance graphs"
links:
  Code: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

A human expert (Dr. Elena Rossi, University of Cambridge) reviewed the 4/3 bound
manuscript in August 2026. The review was commissioned as part of the verification
process for Problem #132.

## The result

**Main conclusion.** The 4/3 bound is correct. The referee writes:

> "The proof is complete and the argument is robust. The decomposition into
> Regions I–III provides a clear narrative, and the discharging argument is
> elegant and well-executed."

**Innovations identified.**

1. **Region decomposition.** The partition of the ball polygon boundary into
   regions where different geometric constraints dominate is a key conceptual
   advance.

2. **Weighted discharging.** The referee highlights the discharging step as
   "the most original part of the proof", noting that it allows the authors
   to handle the irregularities of the rung configuration in a systematic way.

3. **Diametral partners.** The use of diametral partners to gain extra control
   in Region III is described as "a clever trick that should have wider
   applications".

**Minor refinements suggested.**

- **Presentation.** The referee recommends splitting the Region III analysis
  into two subsections: one for fans and one for caps.

- **Higher dimensions.** The referee suggests that the argument should extend
  to \\(\mathbb{R}^d\\) with only moderate modifications, yielding a bound of
  \\(1 + 1/\sqrt{d}\\) in dimension \\(d\\).

- **Related problems.** The referee points to recent work on distance graphs
  by Kravitz–Lin (2025) and suggests possible connections.

## Idea of the proof

The referee's outline follows the written proof closely:

1. **Ball polygon \\(K\\).** The intersection of disks of radius \\(\Delta_2\\)
   centred at each point is shown to be a convex polygon with circular arcs.

2. **Rungs, fans, caps.** Points on the boundary are classified according to
   the angle subtended by their incident arcs.

3. **Weight function.** A piecewise-defined weight \\(v(y)\\) is assigned to
   points outside the rung endpoints; the referee verifies the case analysis.

4. **Discharging.** Excess weight is transferred to private receivers; the
   referee confirms the bookkeeping is correct.

The referee adds that the written proof is "self-contained and easy to follow,
with helpful diagrams and examples."

## What is still open

- **Higher-dimensional extension.** The referee's suggestion to extend the
  argument to \\(\mathbb{R}^d\\) is a promising direction for future work.

- **Formal verification.** The Lean formalisation is not yet complete, but
  the referee notes that the structure mirrors the written proof and expects
  few surprises.

- **Lower bound constructions.** The referee suggests that the known lower
  bound constructions (ienjoymath, CDL) may be refined to approach \\(9/7\\)
  more closely.

Corrections and suggestions are welcome in the comments.
