---
id: ADR-004
status: proposed
date: 2026-06-25
tags: [docs, agents]
---

# ADR-004: Doc rules are placed by consumer, not by topic

## Context

In an agentic setting, the rules that govern documentation — how to write it,
where it lives, how to find it — are themselves read by agents, and not all of
them by the same agent at the same time. Two consumer profiles pull apart:

- **Doc authoring** needs deep rules — terseness, what-to-include, code↔doc
  sync, the opening-intro form, marker discipline. These are consumed only
  _while writing a doc_: an occasional, specialized act.
- **Doc orientation** needs thin rules — where docs live, folder structure,
  naming, "read a folder's intro first". _Every_ actor touching the repo needs
  these on _every_ task, down to a one-line tweak, without spinning up an
  author.

The two have opposite loading economics. Context is the scarce resource in
agentic work: every token in an always-loaded layer taxes every agent invocation
across the whole repo, whether or not it touches docs. Deep authoring rules
placed always-loaded tax all the unrelated work; thin orientation rules buried
inside an on-demand author force a quick-task actor either to miss them or to
pay to load a heavy authoring context just to learn where a doc belongs.

The intuitive way to organize the rules is **by topic** — a "how to write docs"
document, an author definition, the project-instructions file — each a grab-bag
of whatever feels topical. But a single rule often serves both consumers (naming
serves the author who creates a file and the reader who scans for it). Organized
by topic, such a rule would be either duplicated across homes — the
duplication-rot [ADR-002](ADR-002-no-code-duplication-in-docs.md) warns of,
recurring one level up: the governance rules themselves drifting against each
other, instead of a doc drifting from the code it restates — or placed in one
home whose economics are wrong for the other consumer.

## Decision

**Recorded decision — recommended as the default.**

Place each doc-governance rule by its **consumer**, not by topic. Consumer is
the operational handle for the underlying axis — **loading economics**: a rule's
home is the layer whose economics match where its consumer needs it
(always-loaded for any-actor orientation, on-demand for authoring). Consumer
identity is how you read off that layer in the common case, not a second
criterion; where a rule's consumers pull toward opposite economics, economics
decides.

Throughout, the **author** is whoever authors a doc — an agent or a human; the
placement holds for either (one pattern, any actor). The author's home takes one
of two forms — an **inert reference** (a doc loaded only on use, no standing
cost) or a **skill / subagent** (an on-demand body plus a **standing
description**, the description cost ADR-002's Key risk bounds) — decided
separately.

**Placement, rule by rule:**

- **Authoring-only rules** (how to author a doc — terseness, what-to-include,
  code↔doc sync, marker discipline) live in the **author's own on-demand home**
  as their single home. The author is the closest consumer, loading these only
  when authoring begins; its depth (its body — rules, any examples, and the
  like) is paid on use, never pre-loaded, so it can grow without taxing every
  read.
- **Any-actor orientation rules** (where docs live, folder structure, naming,
  read-the-intro-first) live in a **thin, always-loaded hint** plus a **naming /
  structure reference** — reachable by an actor doing a one-line tweak without
  invoking the author. (Its form — an always-loaded agent-instructions file, an
  always-on rule, or a skill/subagent description — is decided separately;
  whichever form, weigh its standing cost against the budget rule below — a
  skill/subagent description is itself an always-loaded tax.)
- **One home per rule**, chosen by who consumes it — the no-duplication
  principle of ADR-002 applied to the governance layer itself. A rule both
  consumers need lives in the always-loaded layer (while it stays thin); a
  reference is **not** a second home — the author may only **link** to it, never
  paraphrase or restate its content, so the rule's text can drift in exactly one
  place.
- **Always-loaded is a standing budget.** Every always-loaded token, and every
  standing skill-or-subagent description, taxes every read, so a rule earns an
  always-loaded slot only when a quick-task actor needs it without the author;
  anything needing depth or worked examples never goes always-loaded. Everything
  else lives on demand.
- **Unclear consumer → default on-demand.** Promote a rule to the always-loaded
  layer only once a quick-task need for it is observed — promoting later is
  cheap; taxing every read pre-emptively is not.

## Consequences

- An actor doing a quick, doc-adjacent task gets its orientation from the thin
  always-loaded layer without paying to load the author; the author's authoring
  body loads on demand, paid only when authoring.
- This placement realizes [ADR-003](ADR-003-positional-orientation-intro.md)'s
  consequence that the convention and the author adopt the opening intro: the
  orientation form (the positional intro, naming) lands in the always-loaded
  layer; the authoring mechanics land with the author.
- This placement also resolves the question ADR-002 deferred ("this ADR sets the
  rule, not its placement"), and generalizes it to all doc-governance rules.
  Carrying the placement out — moving each rule to the home its consumer selects
  — is follow-on implementation work, tracked separately.
- This principle will also govern the placement of a forthcoming
  tree-orientation / TOC-vs-glossary decision (a navigation rule).

## Trigger to revisit

- **Move proposed → accepted when:** an adopting team validates it in practice.
- **Re-home a rule when its consumption pattern shifts** — an authoring-only
  rule that quick-task actors start needing is promoted to the thin layer; the
  reverse demotes.
- **Move to superseded / deprecated when:** the by-consumer cut proves to split
  a rule that genuinely serves both consumers equally (then give it a shared
  home), or the thin always-loaded layer proves too thin in practice (quick-task
  actors keep missing what they need) — then revisit the boundary, not the
  principle.

## Connected

- [ADR-001](ADR-001-optimize-docs-for-agents-first.md) — the agent-first lens;
  minimizing the always-loaded tax is one application of it.
