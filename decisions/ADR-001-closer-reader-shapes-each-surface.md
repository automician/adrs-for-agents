---
id: ADR-001
status: proposed
date: 2026-06-28
tags: [docs, agents]
---

# ADR-001: Let the reader closest to each doc surface shape it

## Context

In an agentic setting these docs have two kinds of reader: humans and AI agents.
The two pull apart on form — a lean, terse form an agent reads more accurately,
with less context to wade through, versus a fuller, more navigable form a human
reading cold takes in more easily (link style, callouts, summaries, navigation
aids). Without a shared tiebreaker, every such choice re-litigates
"terse-for-agents vs fuller-for-humans" from scratch, and any global statement
of whose needs win is both unstable — closeness varies surface by surface — and
needlessly adversarial, inviting a symmetric counter-claim.

We need a rule that resolves these choices without asserting that one kind of
reader matters more than the other overall.

## Decision

On any given doc surface, the **closer reader** — the one who reads that surface
more often and whose work actually lives there — gets the ergonomic lean on that
surface. This is a local observation about the surface, not a standing claim
about whose needs matter more. Concretely:

- **Serve both first.** Most apparent conflicts dissolve: a form that serves
  both readers (e.g. clickable markdown-syntax links — valid link target for an
  agent, navigable for a human) is strictly better. Adopt it; there is no
  trade-off to arbitrate. The closer-reader rule only decides _genuine_
  conflicts.
- **On a genuine conflict, lean to the closer reader of that surface** — but
  never break the other reader: the surface must stay readable and navigable for
  both. The lean decides a surface's form — not its access, and not which
  surfaces an agent is fed to read in the first place (a separate
  context-curation decision, out of scope here).
- **Which reader is closer is read per surface, per context.** Some surfaces
  settle it plainly — agent-loaded docs like a `CLAUDE.md` / `AGENTS.md`, a
  rules file, or a skill's instructions are read far more by agents than by
  people, so they are agent-closer and lean terse; a guide a person browses and
  edits by hand is human-closer and leans the other way. Other surfaces
  genuinely vary — read those per case, not by a blanket default. A more
  hands-on domain, or a particular team, shifts which surfaces are which, and
  the lean follows.
- **A deliberate concession is legitimate** — leaning a surface against its
  closer reader for a good local reason. Make it a conscious, tracked decision —
  an ADR, say, usually for a whole class of surface, not a per-file note — then
  follow it; never silent drift.
- **One layer leans; the other does not.** Only the ergonomic _surface form_ is
  governed by this rule. The structural substrate — the raw, version-controlled
  text itself: transparent, readable and navigable by anyone offline — is
  invariant and serves every reader equally, in every context. The closer-reader
  lean never touches it.

## Consequences

- This is the lens for the format and convention decisions that follow — link
  style, the opening intro, per-folder navigation, callouts, headings, and the
  like. Each resolves either to "the form that serves both", or, on a genuine
  conflict, to the closer reader's form on that surface plus a noted concession
  for the other.
- Reviewers get a principled, repeatable tiebreaker instead of per-case argument
  — and one that frames each call as an observation about a surface, not a
  verdict on who comes first.
- **It cuts both ways.** An always-loaded agent file an agent parses on every
  run leans terse — bare directives, no narrative on-ramp — and a human reading
  it cold takes the denser form, the noted concession. A human-closer surface —
  a contributing guide, or a decision record like this one — keeps its intro,
  its worked examples, the fuller explanation a person reading cold benefits
  from, even though an agent would parse a stripped-down version just as well.
  Same rule, opposite leans — no reader is globally demoted, because closeness,
  not rank, decides.

## Trigger to revisit

- Move proposed -> accepted when an adopting team validates it in practice.
- Move to superseded / deprecated if the closer-reader rule proves wrong in
  practice — e.g. a surface assumed agent-closer turns out to be read mostly by
  humans (re-read its closer reader), or "closeness" stops predicting the right
  lean and a surface needs explicit even-handed treatment instead.
