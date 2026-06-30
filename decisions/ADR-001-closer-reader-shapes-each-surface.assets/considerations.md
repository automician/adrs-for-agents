# Considerations for ADR-001 — deeper grounding for adopters

Not a second ADR — distilled grounding and reflections for a team weighing
ADR-001 (_"Let the reader closest to each doc surface shape it"_): the receipts
behind the closer-reader rule, for when a careful reader presses on it even
after the framing change.

## The form-lean is multi-dimensional and non-monotone — it cuts both ways

The rule is **not** "agents get terse, humans get verbose." Which way a surface
leans is read per surface _and per dimension_ (density, explicitness,
pseudocode-vs-prose, navigation) — and on several dimensions the agent reader
needs **more** explicit text than a human, not less:

- **Pseudocode → agent precision.** Procedures written as pseudocode suppress an
  agent's domain-pragmatic over-inference (in a clean-room read, ~39/160 prose
  vs ~1/160 algorithmic read a procedure too loosely). The lever is the
  **explicit structure** — control flow, ordering, a named actor (`accept(file)`
  drops the implicit "reviewer") — not being shorter; training instructions in
  pseudo-code raised instruction-following by 8–21% across six models for the
  same reason ([2025](https://arxiv.org/abs/2505.18011)).
- **Exclusivity / deontic rules.** Agents over-read "sufficient" as "required"
  where a human infers correctly unaided — so an agent-closer rule needs an
  explicit "sufficient, not required" that a human finds redundant. The clean
  case of _agent needs more than the human_.
- **Ambiguity-bridging.** A bare "read strictly" makes agents over-refuse on
  stated-but-ambiguous facts a human bridges naturally; the fix is to word the
  instruction more carefully, not to make it shorter.

_The clean-room observations above come from our own internal model-evaluations
— not yet published; publication is planned. The cited research is independent
and public._

And there is **no blanket "agents prefer structure"**: the direction and size of
any format effect flip by model, task, and even model capacity (see _This is
measured_ below). So the lean is read per surface and per dimension, with the
agent often on the _more-explicit_ side — never a standing tilt toward either
reader.

## "Agent-optimized" need not lock the human out — raw surface + rendered view

A widely-adopted pattern keeps a raw, agent-shaped surface distinct from the
human-rendered one, so neither reader is sacrificed. **Markdown is the de-facto
raw agent surface**: a 2025 study of 2,303 agent context files (`CLAUDE.md` /
`AGENTS.md` / `copilot-instructions.md`) across 1,925 repositories finds them
authored in Markdown and maintained like configuration code
([Agent READMEs, 2025](https://arxiv.org/abs/2511.12884)). The human-facing
surface renders separately — and the live "HTML for agents" debate is really
about that _rendered output_ (richer artifacts for a person: SVG diagrams,
interactive widgets, in-page navigation), not about the raw input an agent
parses
([Willison, 2026](https://simonwillison.net/2026/May/8/unreasonable-effectiveness-of-html/)).
The practitioner counsel converges: "Markdown by default — token-cheap,
greppable, diffable, matching the model's training prior — HTML only where
structure is load-bearing or the agent acts on a live page"
([2026](https://softmaxdata.com/blog/md-vs-html-file-choices-for-llm-agentic-tasks/)).
That split _is_ closer-reader: the raw input leans agent (Markdown), the
rendered view serves the human (HTML), and the underlying text stays open to
all.

Worked instance — **test-case management as code**: large parameter-combination
test cases stored as raw machine-parseable data (JSON, or sqlite + an
in-markdown SQL query) that a viewer **renders** into a table. The human reads
the _rendered_ view; the raw leans agent; neither is broken — a huge
raw-markdown table needs rendering for a human anyway. Answers
"machine-parseable just locks me out."

## This is measured, not vibes

- **Structured _output_ taxes reasoning only when the model lacks headroom.**
  Forcing JSON output cost a strained small model dozens of points (Claude Haiku
  4.5 −36 points on hard math) while a frontier model with spare capacity took
  no measurable loss (Sonnet 4.6), and letting the model **reason first, format
  last** recovers 80–87% of any loss
  ([Capacity, Not Format, 2026](https://arxiv.org/abs/2606.09410); first shown
  on older models in
  ["Let Me Speak Freely?", 2024](https://arxiv.org/abs/2408.02442)).
- **Format choice is model-dependent — no universal winner.** Across current
  lightweight models, YAML led and XML trailed for nested-data retrieval, while
  Markdown carried the same content in ~34–38% fewer tokens than JSON
  ([2025](https://www.improvingagents.com/blog/best-nested-data-format/)).
- **Trivial micro-formatting still swings accuracy** — up to 76 points from
  spacing / separator / casing changes alone
  ([FormatSpread, 2024](https://arxiv.org/abs/2310.11324); a foundational result
  the 2025–2026 model-dependence findings refine, not retire) — so "tight" must
  never collapse into "arbitrary."

Form demonstrably matters, and it matters differently by reader, task, and model
— exactly what a per-surface rule, not a global ratio, is shaped to handle.

## Terseness buys context economy — but the floor is meaning, not word-count

The real floor is **specification**, not length: terseness only hurts once it
drops a load-bearing requirement.

- **The economy is real.** Bloated context files raised steps and cost by ~20%
  with no reliable success payoff, and generic repository overviews specifically
  didn't help — the value was non-obvious, repo-specific directives
  ([Evaluating AGENTS.md, ETH Zurich 2026](https://arxiv.org/abs/2602.11988));
  "longer files … reduce adherence"
  ([Anthropic](https://code.claude.com/docs/en/memory)).
- **The floor is meaning, not words.** What breaks an instruction is
  _under-specification_ — a missing or ambiguous requirement — not brevity:
  models follow a single requirement ~99% of the time but degrade as
  requirements pile up, and under-specified prompts regress twice as often
  across a model swap
  ([Underspecification, 2025](https://arxiv.org/abs/2505.13360)). So a
  maximally-terse-but-fully-specifying form (complete pseudocode) need not
  breach the floor at all.
- **The failure modes are surface-over-meaning, not too-few-words.** Agents
  over-refuse on benign text that merely _looks_ flagged, fixating on keywords
  over intent ([2025](https://arxiv.org/abs/2505.23473)); frontier models will
  ignore an explicit local redefinition and revert to a globally-learned meaning
  ([Semantic Override, 2026](https://arxiv.org/abs/2602.17520)); reasoning
  models follow the literal letter of "win the game" into hacking it
  ([2025](https://arxiv.org/abs/2502.13295)). Each is a meaning failure a human
  bridges — exactly where an agent-closer surface earns its extra explicitness.
- **Honest limit.** "Agents tolerate a terser form than humans" is
  high-confidence in practice (excess text clogs context → confusion), but the
  _exact_ bound is a **working hypothesis** for a dedicated terseness-bounds
  test — the floor is meaning, and we claim no word-count.

Note this finding runs _with_ the rule, not against it: it says don't bloat the
agent surface, and lean-and-specific is precisely the closer-reader call for an
agent-closer file.

## Why a concession is a tracked decision, not a sign-off form

ADR-001 lets a surface be leaned against its closer reader for a good local
reason — recorded as a conscious, tracked decision (an ADR, usually per class of
surface), never a per-file stamp. The reason is a Goodhart one: a detached
"concession sign-off" form would reward the _appearance_ of having weighed the
other reader over actually weighing it, and the moment it is paperwork it gets
rubber-stamped or skipped. A decision recorded in the artifact — visible in the
diff, decided once and then followed — keeps the cost on substance, not on
producing a proxy. Make hiding expensive at the artifact level; check substance,
not claims. Answers "won't the concession just be gamed, or harden into
bureaucracy?"
