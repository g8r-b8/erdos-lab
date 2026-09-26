---
layout: post
title: "Erdős 132: improvement on Region III to get bound below 4/3"
problem: 132
status: partial result
impact: major
summary: >-
  A new argument removes the Region III obstruction to going below 4/3, giving
  min{μ(Δ₂), μ(δ)} ≤ (13/10 + o(1))n. Written proof with one internal referee pass; not formalised in Lean.
result: >-
  For every finite $$X \subset \mathbb{R}^2$$ with $$\lvert X\rvert = n$$,
  $$\min\{\mu(\Delta_2), \mu(\delta)\} \le \tfrac{13}{10}\,n + C\,n^{2/3}$$
  for an absolute constant $$C$$. In particular, $$9/7 \le L \le 13/10 = 1.3$$,
  improving the previous upper bound $$4/3 \approx 1.333$$.
verification:
  Written proof: "complete, in the paper draft (v3, 25 Sep 2026); Theorem N4 gives the average R-weight ≤ 7.5 in Region III"
  Internal referee passes: "one independent pass; minor presentation fixes only"
  Exact arithmetic: "28 assertions in exact rationals with rigorous trig enclosures; fan/cap examples checked in 50-digit arithmetic"
  Numerics: "adversarial sweep of Region III configurations found no violation of the average bound 7.5"
  Lean 4 / Mathlib: "not formalised; the 15/11 bound is fully formalised, and this improvement builds on the same framework"
  Human expert review: "not yet"
  Novelty check: "2026-09-25: #132 forum thread (latest comment 25 Jul 2026), arXiv searches (CDL 2505.04283 v5)"
links:
  Code, Lean, paper: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

Erdős Problem #132 asks whether every \\(n\\)-point planar set has some distance other than the diameter
occurring between 1 and \\(n\\) times. Clemen, Dumitrescu and Liu (CDL) studied the second-largest distance
\\(\Delta_2\\) and minimum distance \\(\delta\\), asking for

$$
L = \limsup_{n\to\infty}\ \max_{|X|=n}\ \frac{\min\{\mu(\Delta_2),\mu(\delta)\}}{n}.
$$

The current best upper bound is \\(L \le 4/3\\), proved in a companion post. That bound is tight in a narrow
window of the parameter

$$
\tau(X) = \frac{\Delta^2 - \Delta_2^2 - \delta^2}{2\,\Delta_2\,\delta},
$$

called Region III: \\(\sqrt3/2 - 1/50 < \tau < \sqrt3/2 + 3/100\\). Outside this window, the bound drops to \\(21/16\\),
and for \\(\tau > 1\\) it matches the lower bound \\(9/7\\).

## The result

The Region III obstruction comes from a local configuration where rungs between the two boundaries of the ball polygon
\\(K = \bigcap_w D(w,\Delta_2)\\) form essentially equilateral triangles. In this case the rung count achieves
\\(e(S) \le s + p\\), and the average weight on \\(R = X \setminus S\\) is bounded by 8, giving the \\(4/3\\) limit.

**Theorem N4** removes this obstruction by using the diametral partners of boundary points to gain an extra
\\(\tfrac16 p\\) in the rung count, yielding

$$
e(S) \le s + \tfrac56 p + O(1)
$$

in all of Region III. Combined with the average weight bound \\(\sum_{y\in R} v(y) \le 7.5r + O(1)\\),
this gives

$$
\mu(\Delta_2) \le \tfrac32 s - \tfrac12 p, \qquad
\mu(\delta) \le s + \tfrac56 p + \tfrac{15}{16}r + O(1),
$$

and with weights \\(\tfrac{11}{20}\\) and \\(\tfrac{9}{20}\\) we obtain

$$
\min\{\mu(\Delta_2),\mu(\delta)\} \le \tfrac{13}{10}\,n + O(n^{2/3}).
$$

The \\(n^{2/3}\\) error comes from the same shell-removal argument used in the \\(\tau > 1\\) proof.

## Idea of the proof

The improvement rests on two ideas.

1. **Diametral partners give extra control.** Each point \\(x \in S\\) on \\(\partial K\\) has a diametral partner \\(x'\\)
   with \\(\lvert x - x'\rvert = \Delta\\). When \\(x\\) is the inner end of a rung, \\(x'\\) lies outside \\(K\\), and the
   angle between the rung and the segment \\(xx'\\) is constrained by the geometry of \\(\partial K\\). This forces a
   systematic imbalance: rungs tend to be paired with a "missing" tangential edge elsewhere, effectively paying for
   the rung on the \\(\Delta_2\\) side.

2. **Weighted discharging.** After the basic bound \\(v(y) \le 8\\) on individual points, a discharging step transfers
   excess weight from heavy points to their private receivers. In Region III, the diametral partner argument reduces
   the average weight to \\(7.5\\), and the rung count improvement replaces the \\(p\\)-term \\(-\tfrac12 p\\) by
   \\(-\tfrac{7}{12}p\\), saving \\(\tfrac16 p\\) overall.

The argument is local in nature, so it works uniformly across Region III without requiring separate treatment of
fans and caps.

## What is still open

- **Is \\(13/10\\) best possible in Region III?** The construction showing \\(e(S) \le s + p\\) is tight suggests that
  the \\(13/10\\) bound may be close to optimal in this regime, but no matching lower bound is known.

- **Reaching \\(9/7\\) globally.** To prove \\(L = 9/7\\), one must still improve the \\(R\\)-term in Region III from
  average weight \\(7.5\\) to \\(7\\), and handle the \\(p\\)-term more sharply. The \\(9/7\\) construction of ienjoymath
  has \\(\tau \to 0\\), so it lies outside Region III, but similar local patterns may appear.

- **Formalisation** of this improvement in Lean is not yet started; the 15/11 formalisation provides a solid foundation.

- **Problem #132 itself.** This result improves CDL's Problem 1.6 bound; it does not resolve the original problem
  about existence of a frequent non-diameter distance.

Corrections are welcome in the comments below.
