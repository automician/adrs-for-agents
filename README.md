# ADRs for agents

Lightweight Architecture Decision Records (ADRs) for **writing documentation in
an agentic codebase** — one where AI agents are first-class readers and writers
of the docs, alongside humans.

A small, curated set of engineering/process decisions about doc structure and
conventions, each recorded as a one-screen ADR an agent or a human can write and
read cheaply. General methodology, distilled from practice and published under
the MIT license.

## The decisions

The ADRs live in [`decisions/`](decisions/); their format and the conventions
they follow are in [`decisions/_README.md`](decisions/_README.md).

- [ADR-001 — Optimize docs for agents first, humans a close second (~80/20)](decisions/ADR-001-optimize-docs-for-agents-first.md)
  — the lens the others resolve under.
- [ADR-002 — Docs never duplicate code; the only duplication is ephemeral](decisions/ADR-002-no-code-duplication-in-docs.md)
- [ADR-003 — A doc's orientation summary is a positional opening intro](decisions/ADR-003-positional-orientation-intro.md)
  — with a runnable
  [`orient-grep.sh`](decisions/ADR-003-positional-orientation-intro.assets/orient-grep.sh)
  demo.
- [ADR-004 — Doc rules are placed by consumer, not by topic](decisions/ADR-004-doc-rules-home-by-consumer.md)

All carry `status: proposed` — recorded recommendations, not a ratified
standard. Adopt one by trying it in your own practice; the lifecycle
(`proposed → accepted → superseded → deprecated`) is described in
[`decisions/_README.md`](decisions/_README.md).

## License

[MIT](LICENSE) © 2026 Yakiv Kramarenko.
