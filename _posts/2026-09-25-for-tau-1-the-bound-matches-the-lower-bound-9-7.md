---
layout: post
title: "For τ > 1 the bound matches the lower bound 9/7"
problem: 132
status: partial result
impact: major
summary: >-
  If the diameter exceeds the second-largest distance by more than the minimum distance (τ > 1), then
  min{μ(Δ₂), μ(δ)} ≤ 9n/7 + O(n^{2/3}). This matches the known lower bound 9/7 for Problem 1.6 of
  Clemen–Dumitrescu–Liu, in this regime. Written proof with three internal referee passes; not formalised in Lean.
result: >-
  If $$X \subset \mathbb{R}^2$$, $$\lvert X\rvert = n$$, and $$\tau(X) > 1$$ (equivalently $$\Delta - \Delta_2 > \delta$$), then
  $$\min\{\mu(\Delta_2), \mu(\delta)\} \le \tfrac97\,n + C_2\,n^{2/3}$$ for an absolute constant $$C_2$$.
  The main step is Theorem E′: for every nondegenerate $$X$$, the $$\delta$$-graph on the points inside the ball polygon
  $$K$$ satisfies $$3\lvert V\rvert - \lvert E\rvert \ge 2\lvert S \setminus D\rvert - 3\cdot10^4\,n^{2/3}$$.
verification:
  Written proof: "complete, in the paper draft (v3, 25 Sep 2026)"
  Internal referee passes: "three independent passes. The first two found the argument correct but found gaps in an earlier write-up (constants, a missing small-n case, an argument not written out); the third pass, on the complete corrected text, found no errors or gaps"
  Classical inputs: "cited, not re-proved: face boundary walks of plane graphs, non-interlacing of paths in a disc (Jordan curve theorem), Steinhagen's width–inradius inequality, monotone maps between circles (plus 1-Lipschitz nearest-point projection and Cauchy's perimeter formula)"
  Exact arithmetic: "34 assertions in exact rationals (fatness lemma, all constants, the final linear combination)"
  Numerics: "Steps 1–3 of the proof of Theorem E′ tested at 40 digits on 897 configurations (the key length bound is attained to 6 digits, never exceeded); a floating-point adversarial sweep of the conclusion (lenses, near-degenerate and square centre sets, n up to about 2100) found no violation. The topological Steps 4–6 of that proof are not machine-tested"
  Lean 4 / Mathlib: "not formalised"
  Human expert review: "not yet"
  Novelty check: "2026-09-25: #132 forum thread (latest comment 25 Jul 2026 by ienjoymath: lower bound 9/7, conjecture L = 9/7; no upper bounds below 3/2 claimed), arXiv searches (CDL 2505.04283 still v5, no other paper on the problem)"
links:
  Code, Lean, paper: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

[Erdős Problem #132](https://www.erdosproblems.com/132) asks whether, for every set of \\(n\\) points in the plane,
some distance other than the diameter occurs at least once and at most \\(n\\) times. Clemen, Dumitrescu and Liu
([arXiv:2505.04283](https://arxiv.org/abs/2505.04283)) asked (their Problem 1.6) for

$$
L = \limsup_{n\to\infty}\ \max_{|X|=n}\ \frac{\min\{\mu(\Delta_2),\mu(\delta)\}}{n},
$$

where \\(\Delta_2\\) is the second-largest distance, \\(\delta\\) the minimum distance, and \\(\mu(d)\\) the number of pairs at
distance \\(d\\). A construction of ienjoymath on the erdosproblems.com forum gives \\(L \ge 9/7\\), and ienjoymath conjectured
\\(L = 9/7\\). We have proved \\(L \le 15/11\\) (formalised in Lean;
[post]({{ site.baseurl }}{% post_url 2026-09-24-an-upper-bound-of-15-11-for-second-largest-and-minimum-distances %}))
and then \\(L \le 4/3\\) (companion post).

All of these arguments split by the scale-invariant parameter

$$
\tau(X) = \frac{\Delta^2 - \Delta_2^2 - \delta^2}{2\,\Delta_2\,\delta}.
$$

After scaling to \\(\delta = 1\\), \\(\tau > 1\\) holds exactly when \\(\Delta - \Delta_2 > 1\\): the diameter exceeds the
second-largest distance by more than the minimum distance.

## The result

There is an absolute constant \\(C_2\\) such that every \\(n\\)-point set \\(X \subset \mathbb{R}^2\\) with \\(\tau(X) > 1\\) satisfies

$$
\min\{\mu(\Delta_2),\mu(\delta)\} \le \frac{9}{7}\,n + C_2\,n^{2/3}.
$$

This **matches the global lower bound \\(9/7\\)**: sets with \\(\tau > 1\\) cannot do asymptotically better than ienjoymath's
construction. It does **not** show that \\(9/7\\) is attained by sets with \\(\tau > 1\\). The known \\(9/7\\) constructions
have \\(\Delta - \Delta_2 \to 0\\) (with \\(\delta = 1\\)), so they lie outside this regime. Whether some set with \\(\tau > 1\\) reaches \\(9/7\\) is open.
For general sets the best bound remains \\(4/3\\).

The constant is explicit (\\(C_2 = 3\cdot 10^4\\)) and not optimised.

**Status.** This is a partial result on Problem 1.6: it covers one regime of \\(\tau\\). The proof is written out in full and
has had three independent internal referee passes, the last one on the final text. Its numerical constants are checked in
exact arithmetic. It cites four classical facts (listed in the verification box) without re-proving them. It is **not**
formalised in Lean, and no human expert has read it yet.

## Idea of the proof

Scale so that \\(\delta = 1\\), and let \\(G\\) be the unit-distance graph of \\(X\\). Since every vertex has degree at most \\(6\\),
it is natural to measure the *deficiency* \\(\operatorname{Def}(H) = 3\lvert V(H)\rvert - \lvert E(H)\rvert \ge 0\\), so that
\\(\mu(\delta) = 3n - \operatorname{Def}(G)\\). Let \\(D\\) be the endpoints of diameters, \\(S\\) the points with a partner at
distance \\(\Delta_2\\), \\(s = \lvert S\rvert\\), and \\(K = \bigcap_w D(w,\Delta_2)\\) the ball polygon. The points of \\(X\\)
outside \\(D\\) lie in \\(K\\), and those of them in \\(S\\) lie on \\(\partial K\\).

1. **The graph splits.** Every diametral endpoint lies at distance at least \\(\Delta - \Delta_2\\) from \\(K\\). When
   \\(\tau > 1\\) this is more than \\(1\\), so no unit edge joins \\(D\\) to the rest, and
   \\(\operatorname{Def}(G) = \operatorname{Def}(G[D]) + \operatorname{Def}(G[X\setminus D])\\).
2. **The part on \\(D\\).** Points of \\(D\\) are hull vertices. Apart from \\(O(1)\\) bad edges, their unit edges run
   along the hull, at most one on each side of each point, so \\(\operatorname{Def}(G[D]) \ge 2\lvert D\rvert - O(1)\\).
3. **The part inside \\(K\\) (Theorem E′).** Here the bound is \\(\operatorname{Def} \ge 2\lvert S\setminus D\rvert - O(n^{2/3})\\).
   The unit graph is a plane straight-line graph, so Euler's formula expresses the deficiency through the lengths of face
   boundary walks. We remove a shell of points at depth about \\(n^{1/3}\\) below \\(\partial K\\), which costs
   \\(O(n^{2/3})\\). Each point of \\(S\\) on \\(\partial K\\) must then be paid for twice. The first payment comes from the
   boundary walk of the outer face. The second comes from another closed walk: either the boundary of the hole that contains
   the deep core of \\(K\\), or, when there is no such hole, a return path forced by a winding-number argument. A local version
   of this count is false: there are exact configurations where the edges near \\(\partial K\\) alone do not pay \\(2\\) per
   point. That is why the second, global walk is needed.
4. **Combining.** Steps 1–3 give \\(\mu(\delta) \le 3n - 2s + O(n^{2/3})\\), while \\(\mu(\Delta_2) \le \tfrac32 s\\) by
   Vesztergombi. With weights \\(\tfrac47\\) and \\(\tfrac37\\) this gives \\(\tfrac47\cdot\tfrac32 s + \tfrac37(3n - 2s) = \tfrac97 n\\).

Theorem E′ holds for every \\(\tau\\), not just \\(\tau > 1\\). For \\(\tau \le 1\\) the argument breaks at Step 1, because unit
edges between \\(D\\) and \\(K\\) can then exist.

## What is still open

- **Is \\(9/7\\) attained with \\(\tau > 1\\)?** The upper bound matches \\(9/7\\), but no construction with \\(\tau > 1\\) is known
  to reach it.
- **The other regimes.** For \\(\tau \le 1\\), extending this argument needs control of the unit edges between \\(D\\) and
  \\(X \setminus D\\), together with a sharper bound on \\(\mu(\Delta_2)\\) in Regions II and III. In ienjoymath's construction,
  all the tightness sits in exactly those cross edges.
- **The conjecture \\(L = 9/7\\)** remains open. The general bound is \\(4/3\\).
- **Formalisation.** This result is not formalised in Lean.
- **Problem #132 itself.** This is a partial result on CDL's Problem 1.6, not a solution of Problem #132.

Corrections are welcome in the comments below.
