---
layout: post
title: "An upper bound of 4/3 for second-largest and minimum distances"
problem: 132
status: new result
impact: major
summary: >-
  Every planar n-point set has min{μ(Δ₂), μ(δ)} ≤ (4/3)n + C₀, so L ≤ 4/3 in Problem 1.6 of Clemen–Dumitrescu–Liu.
  Outside a narrow window of the parameter τ the bound drops to (21/16)n + C₁. Written proof with internal referee
  passes; not formalised in Lean.
result: >-
  For every finite $$X \subset \mathbb{R}^2$$ with $$\lvert X\rvert = n$$,
  $$\min\{\mu(\Delta_2), \mu(\delta)\} \le \tfrac43\,n + C_0$$ for an absolute constant $$C_0$$. Hence
  $$9/7 \le L \le 4/3$$. If moreover $$\tau(X) \le \sqrt3/2 - 1/50$$ or $$\tau(X) \ge \sqrt3/2 + 3/100$$, then
  $$\min\{\mu(\Delta_2), \mu(\delta)\} \le \tfrac{21}{16}\,n + C_1$$.
verification:
  Written proof (4/3): "complete, in the paper draft (v3, 25 Sep 2026); the one new estimate is Theorem N3 (average R-weight ≤ 8); the other input, e(S) ≤ s + p + C, is part of the formalised 15/11 proof"
  Internal referee passes (4/3): "two independent passes on Theorem N3, the second formed its verdict before reading the first; both found it correct, with cosmetic fixes only"
  Exact arithmetic (4/3): "36 assertions in exact rationals with rigorous trig enclosures, recomputed by a second independent implementation; fan and cap examples checked in 50- and 60-digit arithmetic; floating-point screenings of about 1.4·10⁵ heavy configurations found none outside the proved classification"
  Referee passes (21/16): "Region I and τ > 1: two independent passes (gaps in an earlier write-up, repaired in the current text). Region II: its two inputs (sharper rung count, average weight 7) had one pass each; the Region II text itself has not been refereed"
  Lean 4 / Mathlib: "not formalised. The weaker bound 15/11 is fully formalised; a formalisation of 4/3 is in progress"
  Human expert review: "not yet"
  Novelty check: "2026-09-25: #132 forum thread (latest comment 25 Jul 2026 by ienjoymath: lower bound 9/7, upper bound 3/2 by Vesztergombi; no upper bound below 3/2 claimed); arXiv searches (CDL 2505.04283 still v5, no other paper on the problem)"
links:
  Code, Lean, paper: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

[Erdős Problem #132](https://www.erdosproblems.com/132) asks whether, for every set of \\(n\\) points in the plane,
some distance other than the diameter occurs at least once and at most \\(n\\) times. Clemen, Dumitrescu and Liu
([arXiv:2505.04283](https://arxiv.org/abs/2505.04283)) studied two candidates, the second-largest distance
\\(\Delta_2\\) and the minimum distance \\(\delta\\). Write \\(\mu(d)\\) for the number of pairs at distance \\(d\\).
Their Problem 1.6 asks for

$$
L = \limsup_{n\to\infty}\ \max_{|X|=n}\ \frac{\min\{\mu(\Delta_2),\mu(\delta)\}}{n}.
$$

A construction of ienjoymath on the erdosproblems.com forum gives \\(L \ge 9/7\\), and ienjoymath conjectured
\\(L = 9/7\\). Vesztergombi's inequality \\(\mu(\Delta_2) \le 3n/2\\) gives \\(L \le 3/2\\). In an
[earlier post]({{ site.baseurl }}{% post_url 2026-09-24-an-upper-bound-of-15-11-for-second-largest-and-minimum-distances %})
we proved \\(L \le 15/11 \approx 1.3636\\), and that bound is now formalised in Lean.

## The result

There is an absolute constant \\(C_0\\) such that every \\(n\\)-point set \\(X \subset \mathbb{R}^2\\) satisfies

$$
\min\{\mu(\Delta_2),\mu(\delta)\} \le \frac{4}{3}\,n + C_0 ,
$$

so \\(9/7 \le L \le 4/3\\). The gap shrinks from about \\(0.078\\) to about \\(0.048\\).

Let

$$
\tau(X) = \frac{\Delta^2 - \Delta_2^2 - \delta^2}{2\,\Delta_2\,\delta},
$$

a scale-invariant measure of how far the diameter exceeds \\(\Delta_2\\). A finer version of the argument gives

$$
\min\{\mu(\Delta_2),\mu(\delta)\} \le \frac{21}{16}\,n + C_1
\qquad\text{whenever } \tau(X) \le \tfrac{\sqrt3}{2} - \tfrac1{50} \text{ or } \tau(X) \ge \tfrac{\sqrt3}{2} + \tfrac{3}{100}.
$$

Only the window \\(\sqrt3/2 - 1/50 < \tau < \sqrt3/2 + 3/100\\) ("Region III") stays at \\(4/3\\).
The constants are explicit and very large (\\(C_0 \approx 4.7\cdot 10^9\\), \\(C_1 = 2\cdot10^{32}\\)). We have not tried to
optimise them. For \\(\tau > 1\\) there is a much stronger bound, \\(\tfrac97 n + O(n^{2/3})\\), which is the subject of a
separate post.

**Status.** The \\(4/3\\) bound is a written proof. Its one new ingredient has had two independent internal
referee passes, and all its numerical constants have been checked in exact arithmetic. It is **not** formalised in
Lean: the Lean development covers \\(15/11\\), and a formalisation of \\(4/3\\) is in progress. The \\(21/16\\) bound
has been checked less. Region I and \\(\tau > 1\\) have had two referee passes. In Region II the two inputs have had one
pass each, and the assembled text has not been refereed yet. No human expert has read any of it yet.

## Idea of the proof

As before, let \\(S\\) be the set of points with a partner at distance \\(\Delta_2\\), \\(Q \subseteq S\\) the points
with exactly one such partner, and \\(R = X \setminus S\\), with \\(s = \lvert S\rvert\\), \\(p = \lvert Q\rvert\\) and
\\(r = \lvert R\rvert\\). Vesztergombi's bound gives \\(\mu(\Delta_2) \le \tfrac32 s - \tfrac12 p\\), and there is an
exact identity

$$
\mu(\delta) = e(S) + \tfrac12 \sum_{y\in R} v(y), \qquad v(y) = \deg y + m_y ,
$$

where \\(m_y\\) counts the \\(\delta\\)-neighbours of \\(y\\) in \\(S\\). The \\(15/11\\) proof used \\(e(S) \le s + p + O(1)\\)
and the pointwise bound \\(v(y) \le 10\\). The new step is a bound on the **average**:

$$
\sum_{y\in R} v(y) \le 8r + O(1).
$$

With weights \\(\tfrac23\\) and \\(\tfrac13\\) this gives \\(\tfrac43 n + O(1)\\). The average bound rests on two ideas.

1. **Heavy points pin the geometry.** Call \\(y\\) heavy if \\(v(y) \ge 9\\). Where the boundary of the ball polygon
   \\(K = \bigcap_w D(w,\Delta_2)\\) is nearly flat, a heavy point has one of four local shapes: three "fans" and a "cap".
   Each shape contains a neighbour on \\(\partial K\\) and a diametral endpoint whose heights differ by about
   \\(\sqrt3/2\\) (fans) or about \\(\tfrac12\\) (caps). An exact identity then forces
   \\(t = \Delta - \Delta_2\\) (with \\(\delta = 1\\)) to lie within \\(0.05\\) of that height difference. So fans and caps
   never occur in the same set, and \\(t\\) decides which of them can occur.
2. **Private receivers.** Each heavy point has one or two neighbours deeper inside \\(K\\). These have weight at most
   \\(7\\), and no other heavy point uses them. The heavy point passes its excess over \\(8\\) to them. Afterwards
   every point has weight at most \\(8\\), except for \\(O(1)\\) points near places where \\(\partial K\\) is not flat.

For \\(21/16\\), the same classification is run with much smaller tolerances. In Region I and for \\(\tau > 1\\) only
caps survive, and a discharging along unit edges brings the average weight down to \\(7\\). There is no
\\(p\\)-term in these regimes, and the weights \\(\tfrac58, \tfrac38\\) give \\(\tfrac{21}{16}\\). In Region II the same discharging
works. There, a sharper count of the edges joining the two boundaries ("rungs"), \\(e(S) \le s + \tfrac12 p + O(1)\\),
absorbs the \\(p\\)-term.

## What is still open

- **The gap \\(9/7 \le L \le 4/3\\).** The conjecture is \\(L = 9/7\\).
- **Region III is the only obstacle to going below \\(4/3\\).** Near \\(\tau = \sqrt3/2\\) an exact "hexagonal strip"
  shows that the rung count \\(e(S) \le s + p\\) can be tight locally. A further argument removes this obstruction. It
  uses the diametral partners of the boundary points and gives \\(e(S) \le s + \tfrac23 p + O(1)\\) in all of
  Region III. That argument has had one internal referee pass and is not yet in the paper. What remains is the average
  weight on \\(R\\) in Region III: fans can occur there, and only the bound \\(8\\) is proved. Any average below \\(8\\) in
  Region III would give a bound below \\(4/3\\) for all sets.
- **Reaching \\(9/7\\).** Radius-one discharging stops at average weight \\(7\\). Average weight \\(6\\) in Region I
  would show that sets in Region I cannot beat \\(9/7\\).
- **Formalisation** of \\(4/3\\) in Lean is in progress.
- **Problem #132 itself.** This is a result on CDL's Problem 1.6, not a solution of Problem #132.

Corrections are welcome in the comments below.
