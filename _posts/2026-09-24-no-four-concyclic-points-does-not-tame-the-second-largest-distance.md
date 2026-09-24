---
layout: post
title: "No four concyclic points does not tame the second-largest distance"
problem: 132
status: partial result
impact: note
summary: >-
  Excluding four concyclic points does not bring the second-largest distance down to n + O(1). There are
  convex sets with no four concyclic points in which it occurs 5n/4 times. Every other distance in these
  examples occurs once, so they do not threaten Problem #132 itself. They only rule out Δ₂ as the
  second rare distance.
result: >-
  For every $$n = 4m \ge 12$$ there is a strictly convex $$n$$-point set $$X$$ with no four points concyclic,
  $$\mu(\Delta_2) = \tfrac54 n$$ and $$\mu(\Delta) = \tfrac14 n$$. The existence argument for general $$n$$ is
  written but has not been refereed. The cases $$n = 12, 20, 40$$ are verified to 50 digits. A second,
  non-convex family with no four concyclic points and $$\mu(\Delta_2) = \tfrac54 n - \tfrac32$$ is verified
  numerically for $$n = 14, 22, 42$$ and reported up to $$n = 62$$. In both families every distance other than
  $$\Delta$$ and $$\Delta_2$$ has multiplicity 1.
verification:
  Convex family, n = 12, 20, 40: "50-digit check with independent code: every prescribed equality holds to 5e-51; all other distances are below Δ₂ by a margin of at least 0.008; every point is a hull vertex; the smallest normalised concyclicity determinant over all 4-subsets is at least 1e-8"
  Convex family, larger n: "interval Newton (Krawczyk) boxes of radius 1e-40 also computed for n = 16, 24, 32; not independently re-checked"
  Convex family, all n = 4m ≥ 12: "written proof: seed inequalities by hand, a full-rank Jacobian via a Fourier block decomposition, and exact symbolic checks that no concyclicity determinant vanishes identically; NOT refereed"
  Non-convex family: "numerical only: 80-digit Newton polish with smallest singular value ≫ residual for n = 14, 22, 42; Kantorovich constants not written out; no proof for general n"
  Other distances simple: "checked at 40–55 digits for the n listed above; not proved for general n"
  Matching 5n/4 upper bound in convex position: "SAT-based, with a DRAT proof checked by drat-trim, but the encoding has NOT been audited; not claimed here"
  Human expert review: "not yet"
  Novelty check: "2026-09-24: #132 forum thread (5 comments, newest 25 Jul 2026, none on concyclicity or μ(Δ₂) > n); arXiv search on 'second largest distance', 'four concyclic' + distance, Vesztergombi. Nothing found. Earlier audit of sibling problems and GitHub on 2026-09-23"
links:
  Code, paper: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
---

## Background

[Erdős Problem #132](https://www.erdosproblems.com/132) asks whether every set of \\(n\\) points in the plane has
at least two distances that each occur between \\(1\\) and \\(n\\) times. The diameter \\(\Delta\\) is always one of
them. The second-largest distance \\(\Delta_2\\) is the natural candidate for the other. Write \\(\mu(d)\\) for the
number of pairs at distance \\(d\\). Vesztergombi showed \\(\mu(\Delta_2) \le 3n/2\\) in general, and
\\(\mu(\Delta_2) \le 4n/3\\) for convex sets. So \\(\Delta_2\\) is not always rare.

The known configurations where \\(\Delta_2\\) is frequent are very symmetric. They contain four points
\\(a, b, c, d\\) with \\(|ab| = |cd| = \Delta\\) and \\(|ac| = |bd| = \Delta_2\\). Such a quadruple is an isosceles
trapezoid, so the four points lie on one circle. This suggested a hope: in general position, and in
particular with no four points concyclic, perhaps \\(\mu(\Delta_2) \le n + O(1)\\). An earlier draft of our
paper stated this as a conjecture (Conjecture C1), together with a stronger structural form. Combined with a
layer bound from the same paper, the strong form would have answered #132 for such sets whenever a few points
lie deep inside the convex hull.

Conjecture C1 is false.

## The result

For every \\(n = 4m \ge 12\\) there is a strictly convex set of \\(n\\) points with no four concyclic points and

$$
\mu(\Delta_2) = \tfrac54 n, \qquad \mu(\Delta) = \tfrac14 n .
$$

A second, unrelated family is not convex and has no points at depth \\(\ge 3\\). It has no four concyclic
points and \\(\mu(\Delta_2) = \tfrac54 n - \tfrac32\\). This family is so far only verified numerically.

The status of each piece differs:

- **Convex family, small cases.** Verified to 50 digits for \\(n = 12, 20, 40\\). The prescribed equalities hold
  to \\(5\cdot 10^{-51}\\), and every concyclicity determinant is at least \\(10^{-8}\\).
- **Convex family, all \\(n\\).** The argument is written but not refereed.
- **Non-convex family.** Numerical only. It was polished to 80 digits for \\(n = 14, 22, 42\\), and cases up to
  \\(n = 62\\) were found in the search.

In both families every distance other than \\(\Delta\\) and \\(\Delta_2\\) occurs exactly once. So the first
question of #132 still has a yes answer for these sets: any of those simple distances is rare. The families
show only that under no-four-concyclic, the second rare distance cannot always be \\(\Delta_2\\).

## Idea of the proof

Put \\(\theta = 2\pi/n\\). Place \\(n/2\\) "even" points on a circle of radius \\(\tfrac12\\) and interleave
\\(n/2\\) "odd" points on a concentric circle of radius \\(R\\), where \\(R^2 + R\cos\theta = \tfrac34\\). With
\\(\Delta_2 = 1\\), the following hold:

- each point is at distance 1 from the two points roughly opposite it: \\(n\\) pairs;
- antipodal even points are at distance 1: \\(n/4\\) more pairs;
- antipodal odd points are at distance \\(2R > 1\\), which is the diameter.

That gives \\(5n/4\\) pairs at distance \\(\Delta_2\\). The Δ-pairs join only odd points, and there are no
odd–odd \\(\Delta_2\\)-pairs. So no concyclic trapezoid of the kind above can form.

This seed is itself concyclic, since all the even points lie on one circle. The key step is that the
\\(3n/2\\) distance equations have a Jacobian of full rank at the seed. The proof splits it into Fourier blocks
under the rotation by \\(2\theta\\) and checks that each block determinant is nonzero. So the solutions form a
smooth family of dimension \\(n/2 + 1\\) through the seed. Exact symbolic checks then show that no concyclicity
determinant vanishes identically on this family. A generic nearby point therefore has no four concyclic
points and keeps all the strict inequalities.

The non-convex family is built differently. It starts from a Reuleaux-type polygon on an odd number of hull
vertices. One extra point sits beside each hull edge at distance 1 from both endpoints. Some hull diagonals of length 1
are added too, in a consecutive block that stops one short of closing up. That is exactly what keeps a
concyclic trapezoid from forming.

## What is still open

- **Question.** If no four points of \\(X\\) are concyclic, is \\(\mu(\Delta_2) \le \tfrac54 n + O(1)\\)? Both
  families stop at \\(5/4\\), and a search over several hundred structural types above \\(5/4\\) found no
  valid realisation. For convex sets we have a computer-assisted matching upper bound, but its SAT encoding has
  not been audited, so we do not claim it.
- A referee check of the general-\\(n\\) argument for the convex family, and a proof for the non-convex family.
- Problem #132 itself. This is a partial result: it closes one route to the problem and does not answer it.
  Corrections are welcome in the comments below.
