---
layout: post
title: "An upper bound of 15/11 for second-largest and minimum distances"
problem: 132
status: new result
impact: major
summary: >-
  Every planar n-point set has min{μ(Δ₂), μ(δ)} ≤ (15/11)n + C₀, and ≤ (4/3)n + C₀ in one regime. This
  improves our earlier bound 54/37. The proof is written out and has had internal referee passes. It is not
  yet formalised in Lean.
result: >-
  For every finite $$X \subset \mathbb{R}^2$$ with $$\lvert X\rvert = n$$,
  $$\min\{\mu(\Delta_2), \mu(\delta)\} \le \tfrac{15}{11}\,n + C_0$$ for an absolute constant $$C_0$$.
  If moreover $$\Delta \le 1.94\,\Delta_2$$ and $$\tau(X) \ge \sqrt3/2 + 3/100$$, the bound is
  $$\tfrac43\,n + C_0$$. Hence $$L \le 15/11 \approx 1.3636$$ in Problem 1.6 of Clemen–Dumitrescu–Liu.
verification:
  Written proof: "complete, in the paper draft (v2)"
  Internal referee passes: "independent passes on each step (Region II; Region III, with two passes on the exact case τ = √3/2; the R-point lemma); no mathematical gap found, only presentation fixes"
  Exact arithmetic: "all constants and LP certificates checked in exact rationals (Python Fractions, rigorous bounds for trig functions)"
  Numerics: "adversarial searches against the key lemmas, 0 violations; consistency with ienjoymath's construction checked for n = 60, 120, 250"
  Lean 4 / Mathlib: "NOT formalised for 15/11. The earlier bound 54/37 is fully formalised; a 15/11 formalisation is in progress"
  Human expert review: "not yet"
  Novelty check: "2026-09-24: #132 forum thread (latest comment 25 Jul 2026, no upper bound below 3/2 claimed), arXiv search (CDL 2505.04283 still v5; no other paper on the problem)"
links:
  Code, Lean, paper: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

[Erdős Problem #132](https://www.erdosproblems.com/132) asks whether, for every set of \\(n\\) points in the plane,
some distance other than the diameter occurs at least once and at most \\(n\\) times. Clemen, Dumitrescu and Liu
([arXiv:2505.04283](https://arxiv.org/abs/2505.04283)) looked at two candidates, the second-largest distance
\\(\Delta_2\\) and the minimum distance \\(\delta\\). Write \\(\mu(d)\\) for the number of pairs at distance \\(d\\).
Their Problem 1.6 asks for

$$
L = \limsup_{n\to\infty}\ \max_{|X|=n}\ \frac{\min\{\mu(\Delta_2),\mu(\delta)\}}{n}.
$$

The lower bound \\(L \ge 9/7\\) comes from a construction by ienjoymath on the erdosproblems.com forum, who also
conjectured \\(L = 9/7\\). Vesztergombi's inequality \\(\mu(\Delta_2) \le 3n/2\\) gives \\(L \le 3/2\\).
In an [earlier post]({{ site.baseurl }}{% post_url 2026-09-24-an-upper-bound-below-3-2-for-cdl-problem-1-6 %})
we proved \\(L \le 54/37 \approx 1.4595\\), with a full Lean formalisation.

## The result

There is an absolute constant \\(C_0\\) such that every \\(n\\)-point set \\(X \subset \mathbb{R}^2\\) satisfies

$$
\min\{\mu(\Delta_2),\mu(\delta)\} \le \frac{15}{11}\,n + C_0 ,
$$

so \\(9/7 \le L \le 15/11\\). The gap shrinks from about \\(0.17\\) to about \\(0.08\\).

In one regime the bound is \\(\tfrac43 n + C_0\\). That regime is called Region II: \\(\Delta \le 1.94\,\Delta_2\\) and
\\(\tau(X) \ge \sqrt3/2 + 3/100\\), where

$$
\tau(X) = \frac{\Delta^2 - \Delta_2^2 - \delta^2}{2\,\Delta_2\,\delta}
$$

is a scale-invariant measure of how far the diameter exceeds \\(\Delta_2\\).

The constant \\(C_0\\) is explicit but very large (about \\(5\cdot 10^9\\)). We have not tried to optimise it.

**Status.** This is a written proof. The steps have had independent internal referee passes, and all numerical
constants have been checked in exact arithmetic. It is **not** formalised in Lean: the Lean development covers
\\(54/37\\), and a formalisation of \\(15/11\\) is under way. No human expert has read it yet.

## Idea of the proof

Let \\(S\\) be the set of points with a partner at distance \\(\Delta_2\\), let \\(Q \subseteq S\\) be the points
with exactly one such partner, and let \\(R = X \setminus S\\). Put \\(s = \lvert S\rvert\\), \\(p = \lvert Q\rvert\\) and \\(r = \lvert R\rvert\\).

- **The \\(\Delta_2\\) side.** Vesztergombi's bound applied to \\(S \setminus Q\\) gives
  \\(\mu(\Delta_2) \le \tfrac32 s - \tfrac12 p\\).
- **The \\(\delta\\) side.** There is an exact identity
  \\(\mu(\delta) = e(S) + \sum_{y\in R} \tfrac12(\deg y + m_y)\\). Here \\(e(S)\\) counts \\(\delta\\)-pairs inside \\(S\\), and
  \\(m_y\\) is the number of \\(\delta\\)-neighbours of \\(y\\) that lie in \\(S\\).

The 54/37 argument lost in two places, and both are now repaired.

1. **Pairs inside \\(S\\): \\(e(S) \le s + p + O(1)\\).** Almost every point of \\(S\\) lies on the boundary of the
   ball polygon \\(K = \bigcap_{w} D(w, \Delta_2)\\) or of the convex hull, so it has an inward direction. Almost all
   \\(\delta\\)-edges inside \\(S\\) are either tangential (at most \\(s\\) of them) or "rungs" joining the two
   boundaries. Before, each rung was charged at full price. Now a corner lemma shows that the inner end of a rung
   has only one \\(\Delta_2\\)-partner, so it is in \\(Q\\) and paid for on the \\(\Delta_2\\) side. The one exception is
   a second partner in an exactly determined reflected position. In that case the rung forces a missing tangential
   edge somewhere else. The exact case \\(\tau = \sqrt3/2\\), where rungs form equilateral triangles, needs a rigidity
   argument along a circular arc.
2. **Points outside \\(S\\): \\(\deg y + m_y \le 10\\)** for all but \\(O(1)\\) points \\(y \in R\\), and \\(\le 8\\) in Region II.
   Before, the trivial bound was 12. A point of \\(R\\) that is not a diameter endpoint lies inside \\(K\\), while its
   neighbours in \\(S\\) do not. Where \\(\partial K\\) is nearly flat over a long stretch, those neighbours are confined to an
   open arc of less than \\(240^\circ\\). Since neighbours are at least \\(60^\circ\\) apart, there are at most 4 of them.
   Only \\(O(1)\\) points \\(y\\) sit near a place where \\(\partial K\\) is not flat.

Combining the two sides with weights \\(\tfrac{8}{11}\\) and \\(\tfrac{3}{11}\\) gives
\\(\tfrac{15}{11}(s + r) - \tfrac{1}{11}p + O(1) \le \tfrac{15}{11}n + O(1)\\). In Region II the weights
\\(\tfrac23, \tfrac13\\) give \\(\tfrac43 n\\). The degenerate case \\(\Delta > 1.94\,\Delta_2\\) is handled separately,
and there \\(\mu(\Delta_2) \le n + 1\\).

## What is still open

- **The gap \\(9/7 \le L \le 15/11\\).** In the regime of ienjoymath's construction, all of the remaining gap sits in
  the \\(R\\)-term: the construction's extra points have \\(\deg y + m_y \le 6\\), while we can only prove 10.
- **Limits of the local method.** For \\(\tau < \sqrt3/2\\) there is an exact local configuration with
  \\(\deg y + m_y = 10\\), so a purely local argument cannot beat 10 there. Whether \\(\Theta(n)\\) such points can
  coexist in a near-extremal set is open. A global charging argument is the natural next step.
- **Reaching \\(9/7\\)** would also need a sharper \\(\Delta_2\\) bound in Regions II and III, because of the \\(p\\) term.
- **Formalisation** of \\(15/11\\) in Lean is in progress.
- **Problem #132 itself.** This is a partial result, not a solution.

Corrections are welcome in the comments below.
