---
id: ADR-002
status: proposed
date: 2026-06-24
tags: [docs, agents]
---

# ADR-002: Docs never duplicate code; the only duplication is ephemeral

## Context

Classic, human-oriented documentation tends to **duplicate code** — restating
enum values, constants, type definitions, permission keys, role tables, config
objects, function signatures that already live in the source. Such duplication
rots silently the moment the code changes, and a stale doc is worse than no doc.
The standing rule, then: code is the single source of truth; docs **reference**
code-derived facts by path rather than re-listing them. Higher-level rephrasing
that **adds clarity** — a summary, an abstraction, the why — is not duplication
and is welcome; mirroring code 1:1 is the problem.

Yet duplication is sometimes genuinely useful — onboarding above all: a newcomer
shouldn't have to chase several files to start, so gathering a few code-derived
facts in one place has real first-read value. That tempts a **standing
exception** ("allow duplication in the onboarding doc"). But a single permitted
doc is not a criterion — it leaves "never duplicate" in force everywhere else
while reopening the rot vector exactly where it is waived. **In an agentic
setting the exception is doubly fragile:** a permitted file invites an agent to
over-duplicate throughout it; a criteria-based exception invites it to
confabulate which files qualify — and the cheaper models realistic for broad use
(say, an end-user assistant answering from these docs) slip here far more than
frontier ones. The question stays open — _when, if ever, is duplication worth
its staleness cost?_

There is a sharper answer. The cost of stored duplication is precisely that it
**rots**; a restatement an agent regenerates per request never goes stale — and,
generated from the live source on demand, it leaves no stored exception for an
agent to misjudge. So the home for "duplication that aids understanding" is an
**ephemeral, agent- or skill-driven session**, not an inert doc (a stored file
not auto-loaded into the agent's session context).

## Decision

**Recorded decision — recommended as the default.**

- **Stored / inert docs never duplicate code.** Reference code-derived facts by
  path; never re-list them. Higher-abstraction summary or rationale is fine —
  verbatim restatement of code-derived facts is not. (The core rule, unchanged —
  _not_ relaxed to a per-file exception.)
- **The only sanctioned duplication is ephemeral** — generated on demand by an
  agent or skill in-session. It earns its place only when it **both** (a)
  genuinely aids first-read understanding **and** (b) is produced on demand,
  never stored in an inert doc. The generator holds code references plus
  synthesis and emits per-request, never-stale restatement.
- **That standing exception is not needed.** The onboarding case that tempted it
  is better served by an "onboarder" (a skill and/or agent): its synthesis
  (bootstrap workflow, gotchas, troubleshooting) is generated on demand; its
  volatile duplication (environment, ports, commands, and the like) becomes code
  references. A **very thin inert pointer** stays for a human browsing without
  an agent; the generator's **description** is the always-loaded discoverability
  pointer for AI.
- **Self-documenting code first.** Code that stays non-obvious even after the
  self-documenting-code principle is applied gets a **code comment** (a JSDoc /
  docstring) — on the code, not a separate doc. This applies to agent-facing
  docs too: when an agent struggles, first make the code self-explanatory;
  extend docs only when the code alone cannot carry it.

### Key risk — description cost

Every skill / subagent loads its **description** into context on its own, taxing
every read whether or not it is invoked. So stand up a skill or agent only when
its value justifies that cost; for small needs prefer references or a thin rule.
This bounds the decision: it sanctions _one_ high-value onboarder (in whatever
form — a skill, an agent, or an agent wrapping a skill), not one per restatement
need.

## Consequences

- Inert docs stay reference-only and no stored exception remains: the rot vector
  — stored duplication — is removed **by construction**, not policed by
  discipline.
- The onboarder is the follow-on build that realizes the ephemeral path; the
  onboarding doc is its first candidate.
- **Where this rule is encoded** — across the doc-writing conventions, the
  on-demand author, and a naming / structure reference — is a separate placement
  decision; this ADR sets the rule, not its placement. **Update 2026-06-25:**
  that placement is decided in [ADR-004](ADR-004-doc-rules-home-by-consumer.md)
  (by consumer).

## Trigger to revisit

- **Move proposed → accepted when:** an adopting team validates it in practice.
- **Move to superseded / deprecated when:** a genuine need for _stored_
  duplication appears that no agent / skill / reference can serve, or the
  ephemeral-generation path proves unworkable in practice.

## Connected

- [ADR-001](ADR-001-optimize-docs-for-agents-first.md) — the agent-first
  (~80/20) lens; this ADR's agentic-fragility argument (cheaper models
  confabulate over a stored exception) is one application of it.
