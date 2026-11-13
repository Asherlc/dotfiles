# Global instructions

This file is the canonical location for general memories and persistent preferences that apply across all projects. Prefer writing notes here over the per-project auto-memory system when the user says to "remember" or "make a note" without specifying a scope.

## Answering questions

When the user asks a question (especially "is there an X?", "does Y exist?", "what about Z?"), answer it first. Do not jump into making changes based on assumed intent — a question is not a directive. Only act without confirmation when the user has given an explicit instruction ("do X", "move it to Y").

# Shared personal agent instructions

## Shell commands

Always prefix shell commands with `rtk`. Use `rtk proxy <command>` when raw command behavior or output is required. Use `rtk gain` and `rtk gain --history` for savings analytics. RTK is a token-optimized CLI proxy; see [the installed command reference](/Users/asherlc/.codex/RTK.md).

## Standing user preference: minimum custom code

Satisfy the complete current requirements with the least maintained custom code and operational machinery. Prefer stock platform capabilities, off-the-shelf tools, and existing workflows. Before adding custom code, identify the specific requirement they cannot meet. Use only the smallest domain abstraction needed by actual callers; avoid bespoke CLIs, wrappers, validators, state machines, evidence protocols, and frameworks when existing capabilities suffice. Apply this principle to design, delegation, implementation, and review, and remove unnecessary custom work before shipping. Preserve correctness, safety, operability, and necessary tests; do not confuse fewer maintained concepts with compressed lines. See [Google's review guidance on complexity](https://google.github.io/eng-practices/review/reviewer/looking-for.html#complexity).

## Standing user preference: transitional code testing

Code that exists solely for a migration and has an explicit deletion milestone may be exempted from mutation scores, coverage quotas, and additional automated-test requirements. Do not spend effort adding tests solely to satisfy those gates for disposable code. Keep the migration integrity, erasure, and recovery validation needed to execute it safely. Classify by actual lifetime and callers: permanent behavior is not transitional merely because a migration introduced it, and mixed permanent/transitional modules do not receive blanket exemptions. Reuse existing test-tool exclusions rather than creating a new exemption framework.

<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->

## Storybook links

When sending Storybook links to the user, always link directly to the specific story being discussed using its story path or story ID. Never send only the Storybook root URL.

## Noninteractive tests

Always run tests non-interactively (for example, `vitest run`) so they terminate rather than entering watch mode.

## Paseo tool schemas

Use the live MCP schema when bundled instructions differ. `rename_workspace` takes `title`, not `name`.

## Subagent model selection

When delegating to subagents, prefer the lowest-cost model that can do the job.
Do not default to the most capable or most expensive model (for example
Opus-class) unless the task genuinely needs it or a cheaper model has already
failed. Start cheap and escalate only when justified.
