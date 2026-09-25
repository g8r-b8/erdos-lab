---
layout: post
title: "A lower bound of two billion for consecutive quintic residues"
problem: 436
status: partial result
summary: >-
  There are infinitely many primes p for which the first run of three consecutive quintic residues mod p
  starts at 2,000,028,671. So Λ(5,3) ≥ 2,000,028,671. Whether Λ(5,3) is finite, the open question, is not settled.
result: >-
  $$\Lambda(5,3) \ge 2{,}000{,}028{,}671$$. Here $$\Lambda(k,m) = \limsup_{p\to\infty} r(k,m,p)$$, and
  $$r(k,m,p)$$ is the least $$r$$ such that $$r, r+1, \dots, r+m-1$$ are all $$k$$-th power residues mod $$p$$.
verification:
  Witness: "explicit completely additive f with first zero triple at 2,000,028,671, checked by three independent programs"
  Reduction to primes: "classical (Lehmer–Lehmer–Mills case vectors; Chebotarev + Kummer); written argument, not formalised"
  Lean: "not formalised"
  Human expert review: "not yet"
  Novelty check: "2026-09-24: forum thread (3 comments, no computations), page, formal-conjectures, arXiv, classical papers"
links:
  Checker: https://g8r-b8.github.io/erdos-lab/assets/436/verify_pp.py
  Witness (map): https://g8r-b8.github.io/erdos-lab/assets/436/k5l3_first2000028671.map.gz
  Witness (model): https://g8r-b8.github.io/erdos-lab/assets/436/k5l3_first2000028671.model.gz
---

## Background

[Erdős Problem #436](https://www.erdosproblems.com/436) goes back to Lehmer and Lehmer. Let \\(r(k,m,p)\\) be the least
\\(r\\) such that \\(r, r+1, \dots, r+m-1\\) are all \\(k\\)-th power residues modulo the prime \\(p\\), and let
\\(\Lambda(k,m) = \limsup_{p\to\infty} r(k,m,p)\\). The problem asks whether \\(\Lambda(k,2)\\) is finite for all \\(k\\), and whether
\\(\Lambda(k,3)\\) is finite for all odd \\(k\\).

Pairs are settled: Hildebrand proved \\(\Lambda(k,2) < \infty\\), and exact values are known up to \\(k = 7\\). For triples,
\\(\Lambda(3,3) = 23532\\) (Lehmer, Lehmer, Mills and Selfridge, 1962), and \\(\Lambda(k,3) = \infty\\) for even \\(k\\). The
smallest open case is \\(\Lambda(5,3)\\). As far as we can find, no numerical bound for it has been published.

## The result

$$
\Lambda(5,3) \ \ge\ 2{,}000{,}028{,}671 .
$$

The proof has two parts.

**1. A combinatorial witness.** We exhibit a completely additive \\(f\colon \mathbb{Z}_{>0} \to \mathbb{Z}/5\\), given by its
values on primes. The first \\(r\\) with \\(f(r) = f(r+1) = f(r+2) = 0\\) is \\(r = 2{,}000{,}028{,}671\\).

**2. The classical reduction to primes.** For a prime \\(p\\), the map \\(n \mapsto\\) (index of \\(n\\) mod \\(p\\)) mod 5 is
completely additive on \\(n < p\\), and it vanishes exactly on the quintic residues. Conversely, fix the quintic characters
of the primes \\(q_1 < \dots < q_m\\). The \\(q_i\\) are independent in \\(\mathbb{Q}(\zeta_5)^\*/(\mathbb{Q}(\zeta_5)^\*)^5\\)
(Kummer theory), so by Chebotarev every assignment of their characters occurs for infinitely many \\(p \equiv 1 \pmod 5\\).
Applying this to the primes up to \\(2{,}000{,}028{,}673\\) with the values of \\(f\\) gives infinitely many \\(p\\) with
\\(r(5,3,p) = 2{,}000{,}028{,}671\\). This is the Lehmer–Lehmer–Mills "case vector" framework, which is not new.

## How the witness was found

For each \\(R\\), "there is an \\(f\\) with no zero triple at \\(r \le R\\)" is a finite SAT instance. Plain SAT (kissat) found
models up to \\(R \approx 5.75\cdot 10^6\\), then appeared to stall. On inspection, every one of those models had come from
kissat's "lucky" greedy pre-pass, with zero conflicts. The stall was where that heuristic stopped working, not a hardness
threshold, and real CDCL search on the 6.8M-variable instances was far too slow.

What worked was local search starting from a known model. It repairs zero triples above the current bound by changing
\\(f\\) on large primes, which have few multiples and so cause little collateral damage. Above about \\(1.5\cdot 10^8\\), every
stall was a run of three consecutive 3000-smooth numbers, such as \\(193{,}750{,}000 = 2^4\cdot 5^8\cdot 31\\). These were fixed
by re-solving \\(f\\) on the primes \\(\le 3000\\) against all such runs up to \\(X\\), which is a small SAT problem. After that,
each step up to \\(2\cdot 10^9\\) took under two minutes.

## Verification

The witness is a list of prime values of \\(f\\) (map + model files, 0.8 MB compressed), with every unlisted prime
set to \\(f(p) = 1\\). Three programs recomputed \\(f(n)\\) for all \\(n \le 2{,}000{,}028{,}673\\) and agree on the first zero
triple. They use different methods: a smallest-prime-factor sieve, a segmented C decoder, and a segmented prime-power
accumulation written separately from the search code. A fourth decoder, the encoder's own largest-prime-factor
recursion, agreed at every step up to \\(5\cdot 10^8\\) but does not fit in memory at \\(2\cdot 10^9\\). To re-check it yourself
(about 6 minutes, 1.3 GB of RAM):

```bash
python3 verify_pp.py 5 3 2000028900 <(gzip -dc k5l3_first2000028671.map.gz) <(gzip -dc k5l3_first2000028671.model.gz) 10000000
```

Files: [map](/erdos-lab/assets/436/k5l3_first2000028671.map.gz),
[model](/erdos-lab/assets/436/k5l3_first2000028671.model.gz),
[verify_pp.py](/erdos-lab/assets/436/verify_pp.py). SHA-256 of the uncompressed files: map `85e3c19a…`, model `1bfef1c5…`.

**Not checked:** the reduction in part 2 is a written argument. It has not been formalised or reviewed by an expert.

## What the witness looks like, and what is still open

The witness is not exotic. It has \\(f(p) = 1\\) for almost every prime above 100, so \\(f(n)\\) is roughly
\\(\Omega(n) \bmod 5\\), corrected on a few hundred small primes. Only about 4% of \\(n \le 10^8\\) have \\(f(n) = 0\\).
Since \\(\Omega(n) \bmod 5\\) equidistributes only at a rate like \\((\log n)^{-c}\\), functions of this kind can avoid zero
triples for an astronomically long stretch. So these bounds grow cheaply, and they say little about finiteness.
If \\(\Lambda(5,3)\\) is finite, it is probably far beyond any computation.

Finiteness is equivalent to this: every completely multiplicative \\(g\colon \mathbb{N} \to \mu_5\\) takes the value 1 at
three consecutive integers. Our witness corresponds to a "Liouville-like" \\(g\\). Recent work on correlations of
multiplicative functions (Tao–Teräväinen; Klurman–Mangerel–Teräväinen) handles many cases. What seems to remain is three-point
correlations whose exponents sum to 0 mod 5, which is an open case of the logarithmic Elliott conjecture.

A computational side note: if only primes \\(\le 100\\) are used, the constraints are finite. By Luca–Najman's list, every
run of three consecutive 100-smooth integers starts below 407,498,959, and their erratum adds one more run, at 43,184,400.
The witness avoids a zero at all of them, so a finiteness certificate would need far more primes than 100.
