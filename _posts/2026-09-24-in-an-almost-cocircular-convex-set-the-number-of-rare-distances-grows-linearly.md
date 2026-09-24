---
layout: post
title: "In an almost-cocircular convex set the number of rare distances grows linearly"
problem: 132
status: partial result
impact: notable
summary: >-
  Take n points in convex position with all but w of them on one circle. If n ≥ 3w and n + w ≥ 91, then at
  least (n − 3w + 1)/4 distances each occur between 1 and n times. This answers the second question of #132
  for convex sets that are almost cocircular, and only for those.
result: >-
  Let $$X$$ be a set of $$n$$ points in convex position, $$m = \lfloor n/2 \rfloor$$, and $$\Gamma$$ a circle with
  $$w = \lvert X \setminus \Gamma\rvert$$. Let $$k(X)$$ be the number of distances $$d$$ with $$1 \le \mu(d) \le n$$.
  If $$n \ge 3w$$ and $$\lvert X \cap \Gamma\rvert \ge 4$$, then
  $$k(X) \ge \min\{\tfrac{n-3w+1}{4},\ m - \tfrac w2 - 22 + \tfrac{22}{w+1}\}$$.
  In particular $$k(X) \ge (n-3w+1)/4$$ whenever $$n + w \ge 91$$.
verification:
  Written proof: "Theorem AC, the cocircular (Kneser) lemma and the hit lemma in paper v2. The proof was checked by the project coordinator"
  Independent referee pass: "none yet. This section has not had an adversarial referee pass, unlike the main results of the paper"
  Exact computation: "maximum number of hits for regular M-gons with M ≤ 120, confirmed exactly in ℚ(ζ_M) by arithmetic modulo the cyclotomic polynomial: 13 (at M = 60 and 120), below the proved bound of 23"
  Floating-point sanity check: "regular polygons with holes plus up to 3 adversarial off-circle points, M ≤ 60: the slack against the bound was at least 24 in every case (a check, not a proof)"
  Lean: "not formalised"
  Novelty check: "2026-09-24: the #132 forum thread (5 comments, none about convex or cocircular sets, Kneser's theorem or torsion points), plus web and arXiv searches. Momihara–Shinohara (Amer. Math. Monthly 2017) already apply Kneser's theorem to distance sets on a circle, so our cocircular lemma is a variant of known work. We found no earlier lower bound on the number of rare distances for almost-cocircular sets"
links:
  Code, paper: https://github.com/g8r-b8/erdos132-lean
  Problem page: https://www.erdosproblems.com/132
  Preprint: "arXiv: not yet"
---

## Background

[Erdős Problem #132](https://www.erdosproblems.com/132) has two parts. Call a distance *rare* if it occurs
at least once and at most \\(n\\) times among \\(n\\) points in the plane. Part (a) asks whether there must be two
rare distances. Part (b) asks whether the number \\(k\\) of rare distances must tend to infinity with \\(n\\).

Part (b) is open even in convex position. Clemen, Dumitrescu and Liu
([arXiv:2505.04283](https://arxiv.org/abs/2505.04283)) show that every convex set has at least two rare
distances. One family is easy. If all \\(n\\) points lie on one circle, then every distance is rare: a circle
centred at a point of the circle meets it in at most two points, so each distance occurs at most \\(n\\) times.
The question here is what happens when a few points are moved off the circle.

## The result

Let \\(X\\) be a set of \\(n\\) points in convex position and let \\(m=\lfloor n/2\rfloor\\). Suppose all but \\(w\\) of the
points lie on a circle \\(\Gamma\\), with \\(n\ge 3w\\) and at least 4 points on \\(\Gamma\\). Then

$$
k(X)\ \ge\ \min\Bigl\{\frac{n-3w+1}{4},\ m-\frac w2-22+\frac{22}{w+1}\Bigr\},
$$

and in particular \\(k(X)\ge (n-3w+1)/4\\) once \\(n+w\ge 91\\).

So if \\(w=o(n)\\), then \\(k\ge(\tfrac14-o(1))\,n\\), and the number of rare distances grows linearly. This is a
**partial result**. It answers part (b) only for convex sets that are almost cocircular.

## Idea of the proof

Write \\(C = X\cap\Gamma\\), with \\(q\\) points, and \\(W = X\setminus\Gamma\\), with \\(w\\) points. A simple count shows
\\(k\ge D-m+1\\), where \\(D\\) is the number of distinct distances. If \\(C\\) already has many distances, this count
finishes the proof. The other case, where \\(C\\) has few distances, uses two tools.

- **Kneser's theorem on the circle.** Read the points of \\(\Gamma\\) as angles in \\(\mathbb R/2\pi\mathbb Z\\). A chord
  length determines an angle difference up to sign, so few distances means a small difference set \\(C-C\\).
  Kneser's addition theorem then puts \\(C\\) inside the vertex set of a regular \\(M\\)-gon with
  \\(M\le (3q-1)/2\\). The same idea already appears in work of Momihara and Shinohara on distance sets on circles
  (*Amer. Math. Monthly* 124 (2017)).
- **The hit lemma.** Take a point \\(u\\) that is neither on \\(\Gamma\\) nor at its centre. Then \\(u\\) is at a chord
  length of the regular \\(M\\)-gon from at most 23 of its vertices, for every \\(M\\). Each such coincidence gives a
  point on the curve
  $$\bar u\,x+u\,x^{-1}-y-y^{-1}-(\lvert u\rvert^2-1)=0$$
  whose two coordinates are both roots of unity. This curve is irreducible and contains no torsion coset. By a
  theorem of Beukers and Smyth
  ([*Cyclotomic points on curves*](https://webhomes.maths.ed.ac.uk/~chris/preprints/beukers_smyth.pdf), 2002),
  it therefore has at most \\(22\cdot 2 = 44\\) such points. Each hit gives two of them, except for at most two
  diametral hits, which give one each. That bounds the number of hits by 23.

Now count. Inside \\(C\\) every distance occurs at most \\(q\\) times, so a *frequent* distance (more than \\(n\\) pairs)
needs at least \\(w+1\\) pairs that meet \\(W\\). There are at most \\(23w\\) hits and at most \\(\binom w2\\) pairs inside
\\(W\\). Hence there are at most \\(w/2+22-22/(w+1)\\) frequent distances. Altman's theorem gives \\(D\ge m\\) for convex
sets, and \\(k=D-(\text{number of frequent distances})\\) then gives the second term of the bound.

The loss of \\(3w/4\\), and the factor \\(\tfrac14\\) rather than \\(\tfrac12\\), come from the threshold in the Kneser
step. The constant 23 is not sharp: an exact computation in \\(\mathbb Q(\zeta_M)\\) for every \\(M\le 120\\) finds at
most 13 hits, attained at \\(M=60\\) and \\(M=120\\).

## What is still open

- **Stability off a single circle.** To settle (b) for all convex sets, it would be enough to show that a
  convex \\(n\\)-set with at most \\(n/2+K\\) distances has all but \\(o(n)\\) of its points on one circle. Kneser's
  theorem does this on a circle, and we know no analogue off it. Suppose \\(D=O(n)\\). A theorem of Pach and de
  Zeeuw ([arXiv:1308.0177](https://arxiv.org/abs/1308.0177)) then implies that an algebraic curve with no line or
  circle components carries only \\(O(n^{3/4})\\) of the points, and so does one of any two non-concentric circles.
  So among algebraically structured sets, the only case left is **two concentric circles**.
- Even \\(k\ge 3\\) is open for general convex sets. We know it for even \\(n\ge 6\\) and for \\(6\le n\le 18\\).
- The checking so far is limited. The written proof has been checked once, within the project. It has not had an
  independent referee pass and is not formalised in Lean. Corrections are welcome in the comments below.
