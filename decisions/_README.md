# Decisions

> Engineering and process decisions — how we build and document — recorded as
> lightweight ADRs (Architecture Decision Records). One file per decision:
> `ADR-NNN-<slug>.md`.
>
> Scope is **engineering/process only** ("how we work"). **Product/feature
> decisions live alongside their own feature documentation** — not here.
>
> To add one: copy the template below, take the next number, start at
> `status: proposed`. Propagation: a decision that changes a documented
> convention updates that doc in the same pass.

## ADR format

Frontmatter + four sections. Minimum for a terse one-off: `id` + `status` +
`date` + `## Decision`; in practice fill all four.

```markdown
---
id: ADR-001
status: proposed # proposed | accepted | superseded | deprecated
date: 2026-06-24
tags: [docs] # grep/index aid — keep present
# supersedes: ADR-NNN   # only when this replaces another
# superseded-by: ADR-NNN
---

# ADR-001: <outcome-implying title>

## Context

<situation / forces / why now.>

## Decision

<Pick the shape by how settled the decision is, not by status alone:

- **Firm decision** (a recommended `proposed`, or an `accepted` one) → **flat
  prose**, no hedge; for a firm `proposed`, open with a one-liner like
  `**Recorded decision — recommended as the default.**` (ratification is
  adopter-side — see Trigger to revisit).
- **Genuinely-open question** (`proposed`) → open the heading or first line with
  a working-hypothesis marker + the verifying event —
  `## Decision (proposed — working hypothesis)` or
  `**Proposed (working hypothesis).** Verified by <event>.` — then the question
  and candidate options as labeled `Alternative A / B / C` bullets, each with a
  `Cost:` / `Risk:` line, the pick tagged `(this proposal)`.>

## Consequences

<trade-offs accepted, follow-ons, what this enables or blocks.>

## Trigger to revisit

<the event/condition that reopens this — or "never". For a proposed ADR, prefer
two gates: **Move proposed → accepted when:** … and **Move to superseded /
deprecated when:** ….>
```

## Statuses

- **`proposed`** — drafted and recommended (or an open decision-shaped
  question); awaiting a decision. It is ready to review and adopt.
- **`accepted`** — ratified by whoever adopts it.
- **`superseded`** — replaced by a later ADR (`superseded-by:`); kept, never
  deleted — the record of the reversal is the value.
- **`deprecated`** — no longer applies, no direct successor.

## Conventions

- **Number = permanent identity.** `ADR-NNN` is the stable handle — **cite the
  number, not the path**. Numbers are never reused (not across supersession, not
  to fill gaps), so files can be renamed or re-grouped later (e.g. a topic
  suffix once the log spans multiple areas) without breaking a reference. A
  cross-ref may be a **clickable link carrying the number as its visible text**
  with a relative-path href —
  `[ADR-003](ADR-003-positional-orientation-intro.md)` — linked on **first
  mention per doc**, bare number after; the number stays the citation, the path
  a convenience that may rot.
- **Slug: terse yet descriptive enough** to orient from the filename alone.
  Encode the **decision + purpose + artifact**, with the **decision the
  priority** — it must appear and carries the emphasis (if terseness forces a
  cut, keep the decision). Lead with it by default (e.g.
  `positional-orientation-intro` — positional / orientation / intro); a terser
  or punchier phrasing may reorder it — an apt, idiomatic phrase is itself part
  of being descriptive, so word-order serves terse-yet-descriptive, not the
  reverse. Prefer a full word to a clip that would misread (`orientation`, not
  the verb-like `orient`); drop a synonym already implied. (An instance of a
  broader "descriptive short names" principle — generalized for all docs in a
  forthcoming naming convention.)
- **`tags`** keep the log greppable — filter by topic in search.
- **Refs are grep-derived, not indexed.** Link related docs inline where
  relevant; no maintained cross-ref index. When related docs genuinely have no
  inline home, gather them in a trailing `## Connected` section — residual only,
  not an index of everything. A `## Connected` entry references an **existing**
  doc; a forthcoming (not-yet-existing) related decision is mentioned in prose
  (Consequences or scope), not listed as a Connected reference.
- **Amend in place.** When later work refines a landed ADR, add a dated bullet
  in Consequences (`**Update YYYY-MM-DD:** …`) leaving the original prose intact
  — no separate changelog.
- **Two flavors, kept distinct.** The axis is **general vs project-specific**.
  An ADR either (a) faces a **general** problem — design-level, cross-project
  (an agentic-setting principle is the common case) — or (b) is **project- /
  implementation-coupled** (tied to concrete artifacts, names, delivery forms).
  Keep a general / design-level ADR **implementation-name-free**: it records the
  _what_ and _why_; the concrete realization (names, delivery form) is
  provisional, landing later as an `**Update YYYY-MM-DD:**` amendment or a
  separate project-specific ADR.
- **Decision-meta stays visible.** Status markers, working-hypothesis caveats,
  verifying events, dated amendments are decision-bearing — keep them in body
  prose. Only pure provenance/process asides go in `<!-- -->`.
