---
id: ADR-001
status: proposed
date: 2026-06-24
tags: [docs, agents]
---

# ADR-001: Optimize docs for agents first, humans a close second (~80/20)

## Context

In a modern agentic setting, documentation has two kinds of reader: **AI
agents** and **humans**. How much each matters is itself a team's choice — but
wherever both read, their ergonomics pull apart: a terse, machine-parseable form
versus a richer human-friendly rendering (link style, callouts, summary
formatting, navigation aids). Without a shared tiebreaker, every such choice
re-litigates "agent-native vs human-readable" from scratch.

## Decision

**Recorded decision — the ~80/20 (agent/human) lean, recommended as the default
tiebreaker.**

Optimize primarily for **agent experience (AX-first / ai-native)**, with human
readability a real but secondary constraint — a rough **80/20 (agent/human)**
lean. Concretely:

- When the two **genuinely conflict**, lean to the agent — in this setting the
  closer and more frequent reader of these docs — but **never break human
  readability**: a human must still be able to read and navigate. 80/20 is a
  tiebreaker, not a licence to ignore the 20.
- Most apparent conflicts **dissolve under inspection**: a form that serves both
  (e.g. clickable markdown-syntax links) is strictly better — adopt it, no
  trade-off to arbitrate. The ratio only decides genuine trade-offs.
- A deliberately human-leaning choice (a navigation aid for someone browsing
  without an agent) is legitimate **as part of the 20%** — recorded as a
  conscious concession, not drift.

## Consequences

- This is the **lens** for the format decisions that follow — link style, the
  opening intro, per-folder navigation, callouts, headings. Each resolves to
  "the form that serves both", or, where they truly conflict, the agent-leaning
  form plus a noted human concession.
- It gives reviewers a principled, repeatable tiebreaker instead of per-case
  argument.

## Trigger to revisit

- **Move proposed → accepted when:** an adopting team validates it in practice.
- **Move to superseded / deprecated when:** the ratio proves wrong in practice —
  e.g. these docs turn out to have effectively no human readers (→ lean further
  to agents), or a specific human-facing surface warrants 50/50.
