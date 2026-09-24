---
layout: post
title: "The second and third largest distances can both be frequent"
problem: 132
status: partial result
impact: note
summary: >-
  An exact 8-point set (a regular pentagon plus three equilateral apexes) has its second and third largest
  distances each occurring 9 > 8 times, and odd-ring families push the excess up linearly. So a proof of the
  first question of #132 cannot rely on Δ₂ or Δ₃ alone. We conjecture that one of Δ₂, Δ₃, Δ₄ is always rare.
result: >-
  Write $$\Delta_1 > \Delta_2 > \Delta_3 > \dots$$ for the distances of $$X$$ and $$\mu_j$$ for the number of pairs
  at distance $$\Delta_j$$. (i) There is an 8-point set with $$\mu_2 = \mu_3 = 9$$. (ii) There are sets with
  $$n = (5m-1)/2$$ and $$\min\{\mu_2,\mu_3\} - n = (m-1)/2$$, certified exactly for $$m = 9, 11, 13$$. If the family works
  for every odd $$m$$ (conjectured, not proved), then $$\min\{\mu_2,\mu_3\}/n \to 6/5$$. (iii) Proved: if $$\lvert xy\rvert = \Delta_j$$,
  then the convex-layer depths satisfy $$d(x) + d(y) \le j + 1$$. Conjecture: $$\min\{\mu_2,\mu_3,\mu_4\} \le n$$ for every
  $$n \ge 5$$ and every set with at least four distinct distances.
verification:
  n = 8 example: "exact: every equality inside a distance class proved with sympy minimal polynomials, and the six classes are distinct algebraic numbers (minimum gap 0.29, checked at 60 digits) (r5_a_exact.py, r5_verify_n8.py); independently re-checked in exact arithmetic from the rotation description below; the four new equalities also follow by hand"
  Odd-ring family: "exact for m = 9 (k = 0, 1, 3, 4, 9), m = 11 (k = 1, 5, 11) and m = 13 (k = 1, 6, 13): equalities by minimal polynomials, classes separated at 60 digits (gaps ≥ 6·10⁻³); general m NOT proved"
  Localisation lemma: "written proof; checked exactly on 20,507 random grid instances with 0 failures; the cases j = 1, 2 are formalised in Lean, the general lemma is not"
  Conjecture: "computer search only: about 3,500 sets with μ₂ > n, and none had μ₂, μ₃, μ₄ all > n; not a proof"
  Lean: "not formalised"
  Scripts: "r5_verify_n8.py, r5_c_exact.py in the scripts/ folder of the code repository (added 2026-09-24)"
  Human expert review: "not yet"
  Novelty check: "2026-09-24: #132 forum thread (5 comments, none on Δ₃), Clemen–Dumitrescu–Liu arXiv:2505.04283 (treats Δ₂ and δ, not Δ₃), arXiv searches; earlier audits 2026-09-23 (page, sibling problems, GitHub)"
links:
  Code, Lean, paper: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

The first question of [Erdős Problem #132](https://www.erdosproblems.com/132) asks whether every set of
\\(n\\) points in the plane has two distances that each occur at least once and at most \\(n\\) times. The
diameter \\(\Delta_1\\) always qualifies (Hopf–Pannwitz), so the question is about finding a second one.

Order the distances as \\(\Delta_1 > \Delta_2 > \Delta_3 > \dots\\) and let \\(\mu_j\\) be the number of pairs at
distance \\(\Delta_j\\). The second-largest distance can occur up to \\(3n/2\\) times (Vesztergombi), so
\\(\Delta_2\\) alone cannot answer the question. A natural next hope is that \\(\Delta_3\\) must be rare whenever
\\(\Delta_2\\) is frequent. This post shows that hope is false and suggests what to try instead.

## The result

**An 8-point example.** Let \\(\zeta = e^{2\pi i/5}\\) and \\(P_k = \zeta^k\\) for \\(k = 0,\dots,4\\). These form a regular
pentagon with circumradius 1. Let \\(\omega = e^{-i\pi/3}\\) be the clockwise rotation by \\(60^\circ\\), and add

$$
A = P_0 + \omega(P_2 - P_0),\qquad B = P_0 + \omega(P_4 - P_0),\qquad C = P_3 + \omega(P_2 - P_3).
$$

So \\(A\\) is the outer apex of the equilateral triangle on the diagonal \\(P_0P_2\\). \\(B\\) and \\(C\\) are
the inner apexes of the equilateral triangles on the sides \\(P_4P_0\\) and \\(P_2P_3\\). As complex numbers, all
eight points lie in \\(\mathbb{Q}(\zeta_{15})\\). Numerically:

| point | coordinates |
|---|---|
| \\(A\\) | \\((0.604528, 1.860547)\\) |
| \\(B\\) | \\((-0.169131, 0.122881)\\) |
| \\(C\\) | \\((0.209057, 0)\\) |

The squared distances take six values. Their multiplicities, in decreasing order of distance, are

$$
2,\ 9,\ 9,\ 5,\ 2,\ 1 .
$$

Here \\(\Delta_2 = 2\sin 72^\circ\\) is the diagonal of the pentagon and \\(\Delta_3 = 2\sin 36^\circ\\) is its side:

- \\(\Delta_2\\): the 5 diagonals, plus \\(P_0A\\), \\(P_2A\\), \\(AB\\) and \\(AC\\). That is 9 pairs.
- \\(\Delta_3\\): the 5 sides, plus \\(P_0B\\), \\(P_4B\\), \\(P_2C\\) and \\(P_3C\\). That is 9 pairs.

So \\(\mu_2 = \mu_3 = 9 > 8\\). The only equalities that are not immediate are \\(\lvert AB\rvert = \lvert AC\rvert = \Delta_2\\):

- The rotation by \\(60^\circ\\) about \\(P_0\\) sends \\(P_2 \mapsto A\\) and \\(P_4 \mapsto B\\), so
  \\(\lvert AB\rvert = \lvert P_2P_4\rvert\\).
- The reflection in the line through \\(0\\) and \\(P_1\\) fixes \\(A\\) and swaps \\(B\\) and \\(C\\), so
  \\(\lvert AC\rvert = \lvert AB\rvert\\).

The computer check only has to confirm that there are no further coincidences, so that these two values really
are the second and third largest. The diameter is \\(\lvert AP_3\rvert = \lvert AP_4\rvert \approx 2.827\\).

The set is not a counterexample to #132, because \\(\Delta_1\\) and \\(\Delta_4\\) (5 pairs) are both rare.
Our search found no 7-point example, but that search is not a proof.

**The excess can grow.** Take a regular \\(m\\)-gon \\(V_j = e^{2\pi i j/m}\\) with \\(m\\) odd.

1. Opposite each edge \\(V_jV_{j+1}\\), add a "server" \\(S_j\\). Place it so that
   \\(\lvert S_jV_j\rvert = \lvert S_jV_{j+1}\rvert\\) equals the second-largest distance of the \\(m\\)-gon. This
   \\(2m\\)-point odd ring has \\(\mu_2 = 3m\\), which is the Vesztergombi maximum.
2. Add \\(k\\) depth-3 points \\(P_j\\) on the same axes, with \\(\lvert P_jV_j\rvert = \lvert P_jV_{j+1}\rvert = \Delta_3\\).

Then \\(n = 2m + k\\) and

$$
\mu_1 = m,\quad \mu_2 = 3m,\quad \mu_3 = 2m + 2k,\quad \mu_4 = m .
$$

With \\(k = (m-1)/2\\) this gives \\(\min\{\mu_2,\mu_3\} - n = (m-1)/2\\). For example, \\(m = 13\\) gives
\\(n = 32\\) with \\(\mu_2 = 39\\) and \\(\mu_3 = 38\\).

This profile is certified exactly for \\(m = 9, 11, 13\\). For general odd \\(m\\) we expect the same orbit
computation to work, but that is not proved. If it does work, then \\(\min\{\mu_2,\mu_3\}/n \to 6/5\\). So even
"\\(\min\{\mu_2,\mu_3\} \le n + o(n)\\)" appears to fail.

**A localisation lemma (proved).** Let \\(d(x)\\) be the convex-layer depth of \\(x\\), where the hull vertices
have depth 1. If \\(\lvert xy\rvert = \Delta_j\\), then

$$
d(x) + d(y) \le j + 1 .
$$

For \\(j = 1, 2\\) this recovers two known facts: diameter pairs lie on the hull, and every \\(\Delta_2\\)-pair has an
endpoint on the hull. For \\(\Delta_3\\) the only possible depth types are \\((1,1)\\), \\((1,2)\\), \\((1,3)\\) and
\\((2,2)\\). The family above uses type \\((1,3)\\).

## Idea of the proof

The examples are explicit, and the checks are exact computations in a cyclotomic field:

- Every equality inside a distance class is proved by showing that the difference has minimal polynomial \\(x\\).
- The distance classes are distinct algebraic numbers. They are separated numerically at 60 digits.

For the lemma, suppose \\(x\\) has depth \\(d \ge 2\\), and let \\(Y\\) be the set of points of depth at least
\\(d - 1\\). Maximise the linear functional \\(\varphi(z) = (z - x)\cdot(x - y)\\) over \\(Y\\). Since \\(x\\) is not
a vertex of \\(\operatorname{conv} Y\\), the maximum is \\(\ge 0\\), and it is attained at a vertex \\(z \ne x\\) of
depth \\(d - 1\\). Then

$$
\lvert zy\rvert^2 = \lvert zx\rvert^2 + \lvert xy\rvert^2 + 2\varphi(z) > \lvert xy\rvert^2 .
$$

Each such step lowers the depth sum by 1 and strictly increases the distance. Reaching depths \\((1,1)\\) takes
\\(d(x) + d(y) - 2\\) steps and ends at a distance \\(\le \Delta_1\\). Hence \\(j \ge d(x) + d(y) - 1\\).

## What is still open

- **Conjecture.** For \\(n \ge 5\\) and every set with at least four distinct distances,
  \\(\min\{\mu_2,\mu_3,\mu_4\} \le n\\). This would settle the first question of #132 for such sets.
  - Evidence: we searched about 3,500 sets with \\(\mu_2 > n\\), built from rings, symmetric orbits, and lattice and
    cyclotomic pools. In every one, the first rare index was 3 or 4. The best value of
    \\(\min_{2\le j\le 4}\mu_j - n\\) found was \\(0\\), attained by odd regular polygons and a 12-point lattice set.
  - This is a search, not a proof.
- **Counting alone will not work.** The regular \\((2m+1)\\)-gon has \\(\mu_j = n\\) for every \\(j\\). So a bound on
  \\(\sum_{j \le J}\mu_j\\) cannot settle the question by itself. A proof has to use the rigidity near the top of
  the distance spectrum.
- Does the \\(6/5\\) family work for every odd \\(m\\)? Can 7 points already have \\(\mu_2, \mu_3 > n\\)?
- Problem #132 itself. This is a partial result, not a solution. Corrections are welcome in the comments below.

**Update (2026-09-24).** The verification scripts `r5_verify_n8.py` and `r5_c_exact.py` are now in the public code repository, under `scripts/`.
