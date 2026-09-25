---
layout: post
title: "Erdős #261(iii): continuum-many representations of 1 reduces to an integer orbit"
problem: 261
status: partial result
summary: >-
  A reformulation, not a solution. For dyadic x, whether x = Σ_{a∈A} a/2^a has continuum-many
  representations reduces to whether one integer sequence returns to 1 infinitely often. For x = 1 it
  returns 15 times up to 2·10¹⁰, the last time at 5,145,362,668.
result: >-
  Proved 2026-09-25 (was a sketch; see the Update): for dyadic $$x$$ the number of infinite, non-cofinite representations
  $$x = \sum_{a\in A} a/2^a$$ is $$2^{R}$$, where $$R$$ is the number of levels $$L$$ with $$e_L = 1$$ for
  $$e_{L+1} = \min(2e_L,\ L+2-2e_L)$$. So $$x$$ has $$2^{\aleph_0}$$ representations iff this orbit returns to 1
  infinitely often. For $$x=1$$ ($$e_2 = 1$$) the returns up to $$2\cdot 10^{10}$$ are at L = 2, 4, 80, 236, 432,
  1504, 2944, 6060, 6620, 18912, 54224, 302467996, 1772665632, 2148845168, 5145362668.
verification:
  Written proof: "complete elementary proof added 2026-09-25 (Update, below); originally a sketch"
  Brute-force check: "exact DP over all partial representations of x = 1 up to a = 1600: live-branch count doubles exactly at L = 2, 4, 80, 236, 432, 1504"
  Orbit computation: "C, 64-bit integers, to L = 2·10¹⁰; reproduced independently 2026-09-24"
  Lean: "none"
  Human expert review: "not yet"
links:
  Problem page: https://www.erdosproblems.com/261
  Forum thread: https://www.erdosproblems.com/forum/thread/261
  Formal statement: https://github.com/google-deepmind/formal-conjectures/blob/main/FormalConjectures/ErdosProblems/261.lean
  Tengely–Ulas–Zygadło (2020): https://arxiv.org/abs/2008.01501
---

> **Update (2026-09-25).** The reduction is now proved. Below, the post originally said it was a sketch and
> that no rigorous proof existed. A proof follows, and it also corrects one imprecision: for a general dyadic
> $$x$$ there can be several orbits, not one. The numbers are unchanged.

## Proof of the reduction (added 2026-09-25)

Use $$s_a$$ and the window from the next sections. Assume all $$s_a$$ are integers. For $$x = 1$$ this holds
from $$a = 1$$ on, and for $$x = m/2^k$$ it holds from $$a = k$$ on. Write $$u_a = \min(s_a,\, 2a+2-s_a)$$ for the
distance to the nearer end of $$[0, 2a+2]$$, and $$v_a = a+1-u_a$$ for the distance to the centre $$a+1$$.

1. **Forced moves.** If $$u_a < a$$, exactly one move is possible, and in both mirror cases it gives
   $$u_{a+1} = \min(2u_a,\, 2a+4-2u_a)$$.
2. **Edge of the window** ($$u_a = a$$, so $$s_a \in \{a, a+2\}$$). One move lands on $$0$$ or $$2a+4$$, which
   makes $$A$$ finite or cofinite. The other move gives $$u_{a+1} = 4 = \min(2a,\, 4)$$ for $$a\ge2$$, so the
   same formula holds.
3. **Centre** ($$u_a = a+1$$). Both moves are live and give $$s_{a+1} \in \{2,\, 2a+2\}$$. These two states
   mirror each other and both have $$u_{a+1} = 2$$, which again matches the formula.
4. **No live branch dies.** If $$u_a \ge 1$$, then $$u_{a+1} \ge 2$$. The step commutes with
   $$s \mapsto 2a+2-s$$, so mirror branches keep the same $$u$$.

So every live branch follows the same deterministic orbit. In terms of $$v$$ it reads
$$v_{a+1} = \lvert a - 2v_a\rvert$$. Each branch splits into two live branches exactly when $$v_a = 0$$. An
infinite, non-cofinite $$A$$ is the same thing as an infinite path that never reaches $$0$$ or $$2a+2$$. So
**the infinite, non-cofinite representations number $$2^{R}$$ with $$R = \#\{a : v_a = 0\}$$, or
$$2^{\aleph_0}$$ if $$R = \infty$$.** For a general dyadic $$x$$, finitely many integer states survive at
$$a = k$$, and each has its own orbit. So $$x$$ has continuum-many representations iff one of those orbits
hits $$0$$ infinitely often. For $$x = 1$$, $$s_1 = 2$$ is the centre, so there is a single orbit with
$$v_1 = 0$$.

The $$e$$-sequence below is the same orbit folded once more. Put $$e_{a+1} = \min(v_a+1,\ a+1-v_a)$$ and
$$t = a - 2v_a$$. Then $$L+2-2e_L = \lvert t\rvert+1$$ with $$L = a+1$$, and
$$e_{L+1} = \min(2e_L,\, L+2-2e_L)$$ follows by checking the cases $$t \ge 0$$ and $$t < 0$$.
Here $$e_L = 1$$ iff $$v_a = 0$$, because $$u_a = 1$$ is impossible for $$a \ge 2$$. A direct run of
$$v_{a+1} = \lvert a-2v_a\rvert$$ from $$v_1 = 0$$ to $$a = 2\cdot10^{10}$$ gives zeros at
$$a = L-1$$ for exactly the $$L$$ listed below. Separately, $$e = \min(v+1, a+1-v)$$ was checked numerically
for the first $$3\cdot10^6$$ terms.

## The question

[Erdős Problem #261](https://www.erdosproblems.com/261), part (iii), asks whether some rational $$x$$ has
$$2^{\aleph_0}$$ representations

$$
x = \sum_{a \in A} \frac{a}{2^a}, \qquad A \subseteq \mathbb{N} \text{ infinite}.
$$

Borwein and Loring showed that some reals have uncountably many representations, but their examples are
not rational. Tengely, Ulas and Zygadło ([arXiv:2008.01501](https://arxiv.org/abs/2008.01501)) found
rationals with at least 3 representations, and infinitely many rationals with at least 9. As of
2026-09-23 the problem is open on the site. On the forum thread it is described as open and nobody claims
a proof, and formal-conjectures tags it `research open`.

This post doesn't solve it. It reduces the dyadic case to a question about one integer sequence and gives
the numerics. The reduction didn't turn up in the literature or the thread, so it seems worth writing down.

## The window

Process $$a = 1, 2, 3, \dots$$ in order. Let $$s_a = 2^a\bigl(x - \sum_{b\in A,\, b<a} b/2^b\bigr)$$, which
is the remaining target scaled by $$2^a$$. Then $$s_1 = 2x$$, and

$$
s_{a+1} = \begin{cases} 2(s_a - a) & a \in A,\\ 2 s_a & a \notin A. \end{cases}
$$

The tail satisfies $$\sum_{b \ge a} b/2^b = (a+1)/2^{a-1}$$, so every partial choice that can still be
completed has $$0 \le s_a \le 2a+2$$. Including $$a$$ needs $$s_a \ge a$$, and excluding it needs
$$s_a \le a+2$$. So **a real choice exists only when $$s_a \in [a, a+2]$$.** Everywhere else the next digit
is forced. The value $$s_a = 0$$ means $$A$$ is finite from this point on, and $$s_a = 2a+2$$ means $$A$$
contains every later $$a$$. Both give only countably many representations. The step commutes with the
reflection $$s \mapsto 2a+2-s$$.

## The orbit (dyadic $$x$$)

For dyadic $$x$$ every $$s_a$$ is eventually an integer. Following the forced moves between windows and
folding by the reflection, the branches that stay alive collapse onto one canonical sequence

$$
e_{L+1} = \min\bigl(2e_L,\; L + 2 - 2e_L\bigr).
$$

The number of branches doubles exactly when $$e_L = 1$$. So the number of infinite, non-cofinite
representations is $$2^{\#\{L : e_L = 1\}}$$. **Hence $$x$$ has continuum-many representations iff the orbit
returns to 1 infinitely often.** This is a sketch (proved in the Update above). The claim that live branches never die, only merge onto
the canonical orbit, is checked numerically (below) but not yet written up as a proof.

For $$x = 1$$ the orbit starts at $$e_2 = 1$$ and returns at

$$
L = 2,\ 4,\ 80,\ 236,\ 432,\ 1504,\ 2944,\ 6060,\ 6620,\ 18912,\ 54224,
$$
$$
302467996,\ 1772665632,\ 2148845168,\ 5145362668,
$$

with no further return up to $$L = 2\cdot 10^{10}$$. Orbits started from many other points merge into this
same trunk.

## What was checked

- **Brute force.** An exact rational DP enumerated every partial representation of $$x = 1$$ up to
  $$a = 1600$$, dropping the finite and cofinite absorbing states. The number of live branches is
  1, 2, 4, 8, 16, 32, 64, and it doubles at exactly $$a$$ = 2, 4, 80, 236, 432, 1504. That matches the orbit.
- **Orbit.** The return levels were computed twice, on 2026-09-23 and independently on 2026-09-24, with
  identical output to $$2\cdot10^{10}$$.
- **Not checked.** There is no rigorous proof of the reduction (superseded 2026-09-25: see the Update), no Lean, and no referee.

## Why it's hard

Heuristically the answer should be yes. If returns happen at rate about $$1/L$$, the expected count diverges.
For non-dyadic $$x$$ (1/3, 1/5, 3/7, 5/7) at most 10 states stay live, and the branch count grows like
$$c \log a$$. But proving infinitely many returns means controlling a tent-map-like orbit whose window
keeps moving, and that looks about as hard as digit-distribution questions for specific constants.
A disproof would mean ruling out every return after $$2\cdot10^{10}$$. We have no idea how to do either,
so this is a partial result. Comments and pointers are welcome.
