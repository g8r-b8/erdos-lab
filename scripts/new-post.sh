#!/usr/bin/env bash
# Usage: scripts/new-post.sh <problem-number> "<Title>"
# Creates a draft in _drafts/. Move it to _posts/YYYY-MM-DD-slug.md to publish.
set -euo pipefail
[ $# -ge 2 ] || { echo "usage: $0 <problem> \"<title>\"" >&2; exit 1; }
problem="$1"; title="$2"
slug=$(echo "$title" | iconv -f utf8 -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-|-$//g')
f="$(dirname "$0")/../_drafts/$slug.md"
[ -e "$f" ] && { echo "exists: $f" >&2; exit 1; }
cat > "$f" <<POST
---
layout: post
title: "$title"
problem: $problem
status: partial result        # new result | partial result | formalised
summary: >-
  One or two sentences for the index and link previews.
result: >-
  The precise statement; inline math as $$...$$ (kramdown turns it into \\( \\)).
verification:
  Lean: "sorry-free; axioms: propext, Classical.choice, Quot.sound"
  Novelty check: "YYYY-MM-DD: forum thread, related problems, arXiv"
links:
  Code: https://github.com/g8r-b8/
---

## Background

## The result

## Idea of the proof

## What is still open
POST
echo "$f"
