---
layout: post
title: "An upper bound below 3/2 for second-largest and minimum distances"
problem: 132
status: new result
summary: >-
  Every planar n-point set has min{μ(Δ₂), μ(δ)} ≤ (54/37)n + C₀, improving the bound 3/2 from
  Vesztergombi's inequality. The theorem is fully formalised in Lean 4 with Mathlib.
result: >-
  For every finite $$X \subset \mathbb{R}^2$$ with $$|X| = n$$,
  $$\min\{\mu(\Delta_2), \mu(\delta)\} \le \tfrac{54}{37}\,n + C_0$$ for an absolute constant $$C_0$$.
  Hence $$L \le 54/37 \approx 1.4595$$ in Problem 1.6 of Clemen–Dumitrescu–Liu.
verification:
  Lean 4 / Mathlib: "sorry-free; axioms: propext, Classical.choice, Quot.sound; re-checked by leanchecker and nanoda"
  Human expert review: "not yet"
  Preprint: "in preparation"
links:
  Code, Lean, paper: https://github.com/g8r-b8/erdos132-lean
---

## Background

[Erdős Problem #132](https://www.erdosproblems.com/132) asks whether, for every set of \\(n\\) points in the plane,
some two distances each occur at least once and at most \\(n\\) times. The diameter always qualifies, since it
occurs at most \\(n\\) times (Hopf–Pannwitz). The question is about a second one.

Clemen, Dumitrescu and Liu ([arXiv:2505.04283](https://arxiv.org/abs/2505.04283)) studied the two natural
candidates: the second-largest distance \\(\Delta_2\\) and the minimum distance \\(\delta\\). Write \\(\mu(d)\\) for the
number of pairs at distance \\(d\\). Their Problem 1.6 asks for

$$
L = \limsup_{n\to\infty}\ \max_{|X|=n}\ \frac{\min\{\mu(\Delta_2),\mu(\delta)\}}{n}.
$$

The known bounds were \\(9/7 \le L \le 3/2\\). The lower bound is a construction by ienjoymath on the
erdosproblems.com forum. The upper bound comes from Vesztergombi's inequality \\(\mu(\Delta_2) \le 3n/2\\).

## The result

$$
\min\{\mu(\Delta_2),\mu(\delta)\} \le \frac{54}{37}\,n + C_0 ,
$$

so \\(L \le 54/37 < 3/2\\). In Lean:

```lean
theorem Erdos132Main.erdos132_main :
    ∃ C₀ : ℝ, ∀ X : Finset Pt, 2 ≤ X.card →
      ((min (mult X (dist2 X)) (mult X (minDist X)) : ℕ) : ℝ) ≤ 54 / 37 * X.card + C₀
```

The formal constant is explicit (\\(C_0 = 5\cdot 10^9\\)) and has not been optimised.

## Idea of the proof

- Let \\(S\\) be the set of points with a \\(\Delta_2\\)-partner. Vesztergombi's bound applied to \\(S\\) gives
  \\(\mu(\Delta_2) \le \tfrac32 |S|\\). Also \\(\mu(\delta) \le e_\delta(S) + 6(n - |S|)\\). So any bound
  \\(e_\delta(S) \le k|S| + O(1)\\) with \\(k < 3/2\\) beats \\(3/2\\), and \\(k = 4/3\\) gives \\(54/37\\).
- Each point of \\(S\\) lies on the boundary of the ball polygon \\(\bigcap_w B(w, \Delta_2)\\) or of the convex hull,
  and so has an inward normal. All but \\(O(1)\\) of the \\(\delta\\)-edges inside \\(S\\) join points whose normals are
  almost equal.
- These edges are either tangential or "rungs", and an exact identity fixes the geometry of a rung. An
  ownership/pairing count shows the density of rungs is at most \\(4/3\\). The degenerate case
  \\(\Delta > 1.94\,\Delta_2\\) is handled separately: there \\(\mu(\Delta_2) \le n + 1\\).

## Also in the paper

- **A layer bound.** Let \\(L_1, L_2\\) be the first two convex layers. If no hull vertex has four points at
  distance \\(\Delta_2\\) (for example, if no four points are concyclic), then
  \\(\mu(\Delta_2) \le \tfrac32|L_1| + |L_2|\\). So the answer to #132 is yes whenever at least half as many points
  lie at depth \\(\ge 3\\) as on the hull. This is formalised with standard axioms.
- **Convex position.** At least three distances occur between 1 and \\(n\\) times:
  - for every even \\(n \ge 6\\);
  - for \\(n = 7, 9, 11, 13\\).

  The cases \\(n = 11, 13\\) are new and computer-assisted. They were checked with DRAT/LRAT proof checkers and
  in Lean via `bv_decide`, which is an extra trusted axiom. \\(n = 15\\) is open.

## What is still open

- The gap \\(9/7 \le L \le 54/37\\).
- Problem #132 itself. This result is a partial result, not a solution.
- A human expert has not yet read the paper. Corrections are welcome in the comments below.
