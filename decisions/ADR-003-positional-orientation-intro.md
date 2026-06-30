---
id: ADR-003
status: proposed
date: 2026-06-24
tags: [docs, agents]
---

# ADR-003: A doc's orientation summary is a positional opening intro

## Context

A reader — human or agent — orienting in a docs tree needs each doc's **summary
up front**: a succinct scope line plus a propagation hint, read before deciding
whether to open the doc. The open question is how to **delimit** that summary so
it is both pleasant for humans and reliably machine-extractable.

A **marker-based** delimiter (a leading `>` blockquote, say) has two weaknesses.
The marker is also the natural syntax for **callouts / alerts / admonitions**
(GitHub / GitLab `> [!NOTE]`, MkDocs admonitions), so it can't be reserved for
summaries; and marker extraction (`grep '^>'`) can't tell an intro `>` from a
body callout — every callout is a false positive. The summary's real defining
trait is **positional**: it occupies the space between the `#` H1 and the first
`##` H2, whatever its form.

**Scope:** this ADR settles the **per-doc** orientation summary and its
delimiter. How a reader navigates the **whole tree** — a stored TOC vs
descriptive names + a glossary + grepping these intros — is a separate,
forthcoming decision; the two connect through the orient-grep, which runs over
the intros this ADR defines. So this one comes first (the unit and its
mechanism); the tree strategy builds on it.

## Decision

**Recorded decision — recommended as the default.**

- A doc's summary is its **opening intro**: a summary of **any form** — a
  paragraph, a list, or a few blocks — occupying the space between the `#` H1
  and the first `##` H2. It carries a succinct scope summary + a propagation
  hint, under a terse length budget (**~17 lines** of intro region; soft — the
  split rule handles genuine overflow).
- It is identified **positionally, not by a marker**: no leading `>` is
  required, and `>` is left free for callouts / alerts.
- **Orientation uses positional extraction.** The intro is "everything between
  the H1 and the first H2" — e.g.
  `awk 'f && /^## /{exit} /^# /{f=1; next} f' <file>`. This is **form-agnostic**
  and **callout-immune**, strictly more robust than `grep '^>'`. An agent maps a
  tree by running it over the nested intros — targeted, not "grep everything". A
  runnable demo is in
  `ADR-003-positional-orientation-intro.assets/orient-grep.sh`.

Choosing position over a marker is the rare **both-win**: humans aren't forced
into a blockquote rendering, and agents get cleaner extraction with `>` freed
for callouts — so under [ADR-001](ADR-001-closer-reader-shapes-each-surface.md)
it isn't even a trade-off to arbitrate.

## Consequences

- The project's writing-docs convention and its documentation author (agent or
  human) adopt the **opening intro** (form-free) and the **positional
  orient-grep**; the length budget applies to the intro region.
- **Callouts (`>`-based) coexist cleanly** — positional extraction excludes them
  (they sit after the first `##`); a callout / alert convention, where a project
  needs one, lives separately.
- The positional orient-grep is the mechanism to adopt wherever a `>`-marker
  grep was assumed.

## Trigger to revisit

- **Move proposed → accepted when:** an adopting team validates it in practice.
- **Move to superseded / deprecated when:** a form-free intro proves to lose the
  at-a-glance scannability a marked block gave, or the positional extractor
  proves insufficient in practice (then revisit a marker, or harden the cap from
  soft to hard).
