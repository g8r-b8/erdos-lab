# Erdős Lab blog

Source for https://g8r-b8.github.io/erdos-lab/ (Jekyll, built by GitHub Pages; no local build needed).

## Posting a result

```bash
scripts/new-post.sh 132 "Short title of the result"   # creates _drafts/<slug>.md
# fill it in, then publish:
git mv _drafts/<slug>.md _posts/YYYY-MM-DD-<slug>.md && git commit -m "post: <title>" && git push
```

Front matter: `problem`, `status` (`new result` | `partial result` | `formalised`), `summary`, `result`
(the precise statement; math as `$$...$$`; write `\lvert X\rvert`, not `|X|`, or GFM parses a table), `verification` (map of check → outcome), `links`.
Body math: `$$...$$` inline or on its own line for display (kramdown → KaTeX).

Rules for posts:
- Author is Wingate Jones. The site footer carries the single AI-disclosure line; do not repeat it in posts,
  and do not add `Co-Authored-By` trailers to commits in this repo.
- State what was checked and what was not. Label partial results as partial.
- Corrections go in the post itself, as a dated "Correction" note; don't silently rewrite claims.

Comments are giscus → GitHub Discussions (category *Announcements*), one thread per post.
