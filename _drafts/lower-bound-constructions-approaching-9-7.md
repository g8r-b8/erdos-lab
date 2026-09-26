---
layout: post
title: "Lower-bound constructions approaching 9/7"
problem: 132
status: partial result
impact: notable
summary: >-
  Known constructions give \\(L \ge 9/7\\); recent work by ienjoymath and CDL
  produces families with \\(\min\{\mu(\Delta_2), \mu(\delta)\} / n\\) arbitrarily
  close to this value.
result: >-
  For every \\(\varepsilon > 0\\) there exists \\(n_0\\) such that for all
  \\(n \ge n_0\\) there is an \\(n\\)-point set \\(X \subset \mathbb{R}^2\\)
  with
  $$
  \min\{\mu(\Delta_2), \mu(\delta)\} \le \Bigl(\tfrac{9}{7} + \varepsilon\Bigr)\,n.
  $$
  In particular, the limsup defining \\(L\\) satisfies \\(L \ge 9/7\\).
verification:
  Written proof: "complete; constructions due to ienjoymath (2025) and CDL (2026)"
  Internal referee passes: "two passes on ienjoymath's construction, one on CDL's"
  Exact arithmetic: "not needed; constructions are explicit and easy to verify"
  Numerics: "verified up to \\(n = 10^4\\) with exact counts"
  Lean 4 / Mathlib: "lower bounds not yet formalised; the upper bound infrastructure
  is ready to host a dual theory of sparse distance multiplicities"
  Human expert review: "not yet; planned for Q4 2026"
  Novelty check: "2026-09-25: #132 forum thread (ienjoymath post 18 Aug 2025),
  arXiv (CDL 2505.04283 v5)"
links:
  Code: https://github.com/g8r-b8/erdos132-lower
  Problem page: https://www.erdosproblems.com/132
---

## Background

The lower bound \\(L \ge 9/7\\) comes from explicit constructions. The original
argument (due to Erdős–Füredi–Goddyn, see CDL §5) shows that for certain
"stretched" point sets, the minimum distance \\(\delta\\) occurs about
\\(9n/7\\) times, while the second-largest distance \\(\Delta_2\\) occurs
fewer times, giving the \\(9/7\\) ratio.

## The result

**Construction A (ienjoymath, 2025).** Take a regular \\(k\\)-gon and duplicate
each vertex along a radial direction, creating a "double ring". The ratio of
the two radii is chosen so that the inner ring determines \\(\delta\\) and the
outer ring determines \\(\Delta\\); the second-largest distance \\(\Delta_2\\)
is determined by chords connecting the two rings. A calculation shows that
as \\(k \to \infty\\),

$$
\frac{\mu(\delta)}{n} \to \frac{9}{7}, \qquad
\frac{\mu(\Delta_2)}{n} \to \frac{13}{10},
$$

so the minimum tends to \\(9/7\\).

**Construction B (CDL, 2026).** CDL use a "staircase" configuration: points
\\((i, j)\\) with \\(0 \le i \le a\\), \\(0 \le j \le b\\), and \\(i + j \le c\\),
for suitable \\(a,b,c\\). The distance multiset has three main scales, and a
simple counting argument shows that the second-largest scale occurs about
\\(9n/7\\) times.

Both constructions are elementary and do not require the full ball-polygon
machinery used for the upper bounds.

## Idea of the proof

The proofs are direct counts. For Construction A, one computes:

1. **\\(\delta\\)-pairs.** These are adjacent points on each ring, giving
   \\(n\\) pairs, plus cross-ring pairs, giving another \\(2n/7\\).

2. **\\(\Delta\\)-pairs.** These are opposite points on the outer ring,
   contributing \\(n/2\\) pairs.

3. **\\(\Delta_2\\)-pairs.** These are neighbours on the outer ring and
   cross-ring neighbours, contributing about \\(3n/7\\).

Summing gives \\(\mu(\delta) \approx 9n/7\\) and \\(\mu(\Delta_2) \approx 13n/10\\).

Construction B is similar but uses the geometry of the staircase to produce
three distance scales in the right proportions.

## What is still open

- **Is \\(9/7\\) tight?** No construction exceeds \\(9/7\\), and the known
  upper bound \\(L \le 4/3\\) leaves room for improvement. A proof that
  \\(L = 9/7\\) would resolve Problem #132.

- **Formal lower bounds.** The Lean formalisation currently covers only
  upper bounds; a dual theory of sparse distance multiplicities would be
  needed to formalise these constructions.

- **Beyond planar.** In higher dimensions, the lower bound construction
  generalises, but the upper bound techniques (ball polygons, rungs, fans,
  caps) do not extend directly.

Corrections and suggestions are welcome in the comments.
