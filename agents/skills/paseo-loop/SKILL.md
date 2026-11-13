---
name: paseo-loop
description: Run an agent loop until an exit condition is met. Use when the user says "loop", "babysit", "keep trying until", "check every X", "watch", or wants iterative autonomous execution.
user-invocable: true
---

# Paseo Loop Skill

A loop is a worker/verifier cycle: launch a worker → check verification → repeat until done or limits hit. Use for "keep trying", "babysit", or "watch this until X."

For lightweight recurring checks that should return to this same conversation, create a heartbeat with `create_heartbeat` and delete it with `delete_heartbeat` when finished. Use a loop when each iteration needs a worker/verifier lifecycle; use `create_schedule` only when each firing should start a fresh, independent agent.

**User's arguments:** $ARGUMENTS

## Prerequisites

Read the **paseo** skill. Before choosing worker or verifier providers, call `list_profiles` and read every profile's notes, unless the user explicitly named providers in this request. If no profile fits, or none are configured, use `list_providers` and `list_models`, and say which providers you picked.

## Your job

1. Understand the user's intent from `$ARGUMENTS` and the conversation.
2. **Worker prompt** — self-contained, concrete about what to do this iteration, explicit about what counts as progress.
3. **Verification** — pick the right shape:
   - Shell check for objective criteria a command can answer (`gh pr checks --fail-fast`, `npm test`); run it yourself after each iteration.
   - Verifier agent for judgment ("Return done=true only if all tests pass and the changed files are coherent. Cite the command and the outcome.").
   - Both, when shell rules out the obvious failures and the verifier judges the rest.
4. **Providers** — worker and verifier from the profile notes, or the user's named choices. For implementation loops, pair them on different providers — each catches the other's blind spots.
5. **Launch** — `create_agent` with `title`, the worker prompt, `settings` materialized from the chosen profile, and `notifyOnFinish: true`. Send each later iteration with `send_agent_prompt`; keep `notifyOnFinish: true` so its completion notification reports the result.
6. **Wait** — record the deadline before launching, then finish your turn and wait for the completion notification instead of polling. When a wall-clock limit is requested, arm a bounded heartbeat with `create_heartbeat` so the deadline is checked while an iteration is still running; once elapsed, `cancel_agent` the running worker or verifier and then `delete_heartbeat`. Cron cadence sets the check's precision (it is not an exact hard timeout), so set the heartbeat's `expiresIn` beyond the first scheduled check after the deadline plus a scheduling margin; otherwise the cancellation check can be lost.
7. **Stops** — decide a maximum iteration count and/or elapsed time before starting (for example 10 iterations or 1 hour), check the limits before each subsequent dispatch, and stop when either is reached. Open-ended loops are how runaways happen.
8. **Clean up** — `archive_agent` the worker and verifier when the loop ends unless the user wants them inspected, and delete any heartbeat you created.

## Common shapes

**Babysit a PR** — worker checks PR state and fixes issues; shell check is `gh pr checks <n> --fail-fast`; re-check every 2 minutes with a heartbeat; stop after 1 hour.

**Drive tests to green** — worker investigates failures and fixes code; shell check is the test command; verifier confirms all tests pass; stop after 10 iterations.

**Cross-provider implementation** — worker and verifier on different providers; verifier checks changed files, runs typecheck and tests; bound both iterations and total time; keep the agents for inspection.

## Prompt rules

**Worker** — self-contained, concrete (commands, files, branches, tests, PRs, systems), explicit about what counts as progress this iteration.

**Verifier** — checks facts, doesn't suggest fixes, cites commands/outputs/file evidence, specific about what "done" means.
