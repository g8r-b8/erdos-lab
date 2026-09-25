---
layout: post
title: "Finiteness of Λ(5,3) reduces to twelve three-point correlations"
problem: 436
status: partial result
summary: >-
  Λ(5,3) is finite if and only if every completely multiplicative g into the fifth roots of unity that
  is "strongly non-pretentious" takes the value 1 at three consecutive integers. Only 12 of the 124
  relevant correlations are not controlled by known theorems. Conditionally on the logarithmic
  three-point Elliott conjecture, Λ(k,3) is finite for every odd k.
result: >-
  $$\Lambda(5,3) < \infty$$ if and only if every completely multiplicative $$g\colon \mathbb{N} \to \mu_5$$
  that weakly pretends to no Dirichlet character has some $$n$$ with $$g(n) = g(n+1) = g(n+2) = 1$$.
  Conditionally on the log-averaged three-point Elliott conjecture, $$\Lambda(k,3) < \infty$$ for every odd $$k$$.
verification:
  Written proof: "yes (full case analysis, linked below)"
  Referee: "one adversarial AI referee pass; one real gap found (Case A, non-squarefree modulus) and fixed"
  Human expert review: "not yet"
  Lean: "not formalised"
  Novelty check: "2026-09-25: erdosproblems.com/436 still open; eight arXiv papers read; the conditional deduction is presumably folklore"
links:
  Full case analysis (§7 + referee report §8): https://g8r-b8.github.io/erdos-lab/assets/436/case_analysis_s7_s8.txt
  Earlier post (lower bound): https://g8r-b8.github.io/erdos-lab/2026/09/a-lower-bound-of-two-billion-for-consecutive-quintic-residues/
---

## Background

In the [previous post](/erdos-lab/2026/09/a-lower-bound-of-two-billion-for-consecutive-quintic-residues/)
we showed \\(\Lambda(5,3) \ge 2{,}000{,}028{,}671\\), where \\(\Lambda(k,3)\\) is the limsup over primes \\(p\\) of the
first \\(r\\) such that \\(r, r+1, r+2\\) are all \\(k\\)-th power residues mod \\(p\\). The witness behaved like
\\(\Omega(n) \bmod 5\\), which suggested that computation cannot settle finiteness. This post asks what the theory
of correlations of multiplicative functions says instead.

By compactness plus Chebotarev (the classical Lehmer–Lehmer–Mills reduction),

$$
\Lambda(5,3) < \infty \iff \text{every completely multiplicative } g\colon \mathbb{N}\to\mu_5 \text{ has some } n \text{ with } g(n)=g(n+1)=g(n+2)=1 .
$$

Because \\(g\\) takes values in \\(\mu_5\\), the indicator of such a "zero run" expands exactly into correlations:

$$
\mathbf{1}[g(n)=g(n+1)=g(n+2)=1] = \frac{1}{125}\sum_{a,b,c \in \mathbb{Z}/5} g^a(n)\,g^b(n+1)\,g^c(n+2).
$$

So it is enough to show the 124 nontrivial correlations do not cancel the main term \\(1/125\\), at least along some scales.

## The result

Split \\(g\\) by how well it "pretends" to be a Dirichlet character (the Granville–Soundararajan distance
\\(D(g,\chi;x)^2 = \sum_{p\le x}(1-\mathrm{Re}\,g(p)\bar\chi(p))/p\\)).

| Case | Definition | Status |
|---|---|---|
| A | \\(D(g,\chi;\infty) < \infty\\) for some \\(\chi\\) | **Proved** (elementary): zero runs have positive lower density |
| B | not A, but \\(D(g,\chi;x)^2 = o(\log\log x)\\) for some \\(\chi\\) | **Proved** from Klurman–Mangerel–Teräväinen: zero-run density \\(\to 1/125\\) along a density-1 set of scales |
| C | neither | 112 of the 124 correlations vanish by Tao–Teräväinen and Tao; **12 remain open** |

**Theorem.** \\(\Lambda(5,3) < \infty\\) if and only if every \\(g\\) in case C has a zero run.

The 12 open correlations are exactly the three-point terms \\(g^a(n)g^b(n+1)g^c(n+2)\\) with \\(a,b,c \ne 0\\) and
\\(a+b+c \equiv 0 \pmod 5\\): the product of the three functions is trivial, which is precisely the situation the
current log-Elliott results cannot handle. Our near-counterexample from the previous post (and \\(\zeta^{\Omega(n)}\\))
lies in case C.

**Conditional corollary** (a routine combination, presumably folklore). If the log-averaged three-point
Elliott conjecture holds, then \\(\Lambda(k,3) < \infty\\) for every odd \\(k\\).

## Idea of the proof

**Case A.** Such a \\(g\\) agrees with a character \\(\chi\\) of order dividing 5 except on a set \\(E\\) of primes with
\\(\sum_{p\in E} 1/p < \infty\\). Since \\(k\\) is odd, \\(\chi(-1) = 1\\). Let \\(L\\) be the product of the small primes
in \\(E\\) and take \\(n_0 = L^{5j} - 1\\) with the modulus \\(q\\) of \\(\chi\\) dividing \\(L^{5j}\\). Then
\\(g(n_0+1) = g(L)^{5j} = 1\\), while \\(n_0 \equiv -1\\) and \\(n_0 + 2 \equiv 1 \pmod q\\) are coprime to \\(L\\), so
\\(g = \chi(\pm 1) = 1\\) on them. A sieve over the progression \\(n \equiv n_0 \pmod{qL^{5j+1}}\\) removes the large
exceptional primes and leaves a positive density of zero runs. (This is where odd \\(k\\) matters: for even \\(k\\),
\\(\chi(-1) = -1\\) is possible, matching the known \\(\Lambda(k,3) = \infty\\).)

**Case B.** Klurman–Mangerel–Teräväinen ([arXiv:2304.05344](https://arxiv.org/abs/2304.05344)), Lemma 6.1 and
Theorem 4.1: all powers of \\(g\\) are simultaneously close to twisted characters on short prime ranges along one
set of scales of logarithmic-logarithmic density 1, and there all 124 correlations tend to 0.

**Case C.** Tao–Teräväinen ([arXiv:1708.02610](https://arxiv.org/abs/1708.02610), Cor. 1.6) kills every term
whose product \\(g^{a+b+c}\\) is non-trivial; Tao ([arXiv:1509.05422](https://arxiv.org/abs/1509.05422), Cor. 1.5)
kills the two-point terms with \\(a+b \equiv 0\\), after a short lemma that non-pretentious \\(\mu_5\\)-valued
functions satisfy its hypothesis. What is left is the set of 12 terms above.

**The 12 terms really are a barrier.** The uniform measure on the 25 triples \\((x, x+t, x+3t+1)\\) in
\\((\mathbb{Z}/5)^3\\) satisfies all 112 known vanishing conditions but gives no mass to \\((0,0,0)\\). So case C
cannot be closed from the known correlation facts alone; it needs new arithmetic input. This is the same
"local Bohr set" obstruction Tao and Teräväinen describe in
[Value patterns of multiplicative functions](https://arxiv.org/abs/1904.05096) (there the level-set densities
must sum to more than 1; here they sum to 3/5).

## What was checked, and what was not

- Every theorem number was read from the arXiv PDFs, not quoted from memory.
- An adversarial referee pass checked each step. It found one real gap: the Case A argument originally used
  the modulus \\(L^{5j+1}\\), which fails when \\(q\\) is not squarefree (counterexample \\(q = 25\\)). Using
  \\(qL^{5j+1}\\) fixes it. It also found that the "easy" direction of the theorem needs the Chebotarev step,
  not just a triviality. Both are fixed in the linked write-up, and the referee report is included there.
- The 112/12 split was re-derived by enumerating all of \\((\mathbb{Z}/5)^3\\).
- **Not done:** review by a human expert; formalisation. The conditional corollary is almost certainly known
  in spirit; we record it only for completeness.

## What is still open

The whole difficulty of Λ(5,3) is now one statement: *every completely multiplicative \\(g\colon\mathbb{N}\to\mu_5\\)
that weakly pretends to no character takes the value 1 at three consecutive integers.* The first test case is
\\(g = \zeta^{\Omega(n)}\\), twisted on finitely many primes. For \\(k=3\\) the analogous problem for \\(\zeta^{\omega(n)}\\)
was solved by Tao and Teräväinen using the fact that the open terms form a single line; for \\(k = 5\\) they do not.
