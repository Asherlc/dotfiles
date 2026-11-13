# Personal agent configuration

The repository's root `AGENTS.md` owns shared personal instructions. This directory
owns RTK guidance, personal skills, provider settings, and global Paseo settings.

Run `make install_agents` from a **long-lived checkout**. It links the reviewed
files into your home directory without installing dependencies or restarting
applications. For a different home, use `make install_agents TARGET=/path/to/home`.
Existing regular files and skill directories must be backed up and moved aside
first; the installer refuses to replace them. Existing symlinks are repointed.

The native Codex, Claude Code, Gemini CLI, and OpenCode instruction entry points
remain relative symlinks to `~/.agents/AGENTS.md`, which links to root `AGENTS.md`.
Personal skills get individual links under `~/.agents/skills`; the custom
`paseo-loop` entry point for Claude links through that directory. Paseo installs
and updates its six bundled skills outside this checkout. They are not vendored
here: startup updates otherwise follow the symlinks and overwrite tracked files.
Plugin-owned `paseo-progress`, Claude `synced`, installed skill lockfiles, and
system skills remain managed by their original tools. Do not replace entire
harness directories.

When upgrading an older symlinked setup, preserve the six bundled skill
directories as real directories under `~/.agents/skills` before removing their
old repository copies. The one-time reconciliation backup retains those files.
Run Paseo to install or refresh bundled skills; `make install_agents` leaves
them untouched. The shared instructions retain the known workspace-title
parameter correction without forking the bundled guide.

## Live settings and reviewed examples

The installer links Claude and Gemini settings, Codex/Cursor hooks, Cursor MCP
settings, OpenCode CLI display settings, and Paseo config and plugin preferences.
Paseo profiles, its appended system prompt, custom providers, and plugin selections
are included. Agent/session state, credentials, schedules, caches, downloaded
plugins, and generated project/tool trust approvals stay local.

Keep shared delegation rules in `paseo/config.json`'s `daemon.appendSystemPrompt`;
profile notes describe only each role and any profile-specific constraints.
Model IDs and runtime options belong in the profiles. The OpenRouter profile is
an alternative free worker, subject to the same current-price checks. The reviewed
config omits the disabled `beautiful-chat` registration and the unavailable Devin
provider; installed plugin files remain local.

Three files are **examples only** and are never installed automatically:

- `codex/config.toml.example`: API keys replaced with `REPLACE_LOCALLY`; generated
  project trust, hook approvals, app computer-use state, notices, and marketplace
  cache paths removed. The live `~/.codex/config.toml` retains its credentials.
- `opencode/opencode.json.example`: the GonkaGate key uses OpenCode's
  `{env:GONKAGATE_API_KEY}` reference. Supply that environment variable before
  manually adopting it. The current live config remains untouched.
- `cursor/cli-config.json.example`: account identity, server/privacy caches,
  model selection history, and per-model parameter history removed. The live CLI
  config remains untouched.

Compare examples with live files when updating settings; there is no custom
merge or secret-injection layer. Never copy live configs wholesale into Git.
Claude's existing `settings.local.json` and authentication files remain local.

## Machine-specific dependencies

This is a personal macOS setup. Reviewed `/Users/asherlc` paths are retained where
needed to preserve current behavior: Superset hooks, iTerm status hooks, the local
TokenEconomizer checkout, the Gemini launcher, and Paseo's installed plugin paths
(including installation IDs). The Codex example also references 1Password.app and
the mise Node installation. Those programs and hooks must already exist; this
installer does not install or copy them. On another machine, review these paths
and reinstall plugins before applying settings. JSON/TOML paths are not assumed
to expand `~` or environment variables.

Paseo reads `~/.paseo/config.json`; its [configuration documentation](https://paseo.sh/docs/configuration.md)
describes reloading edits. Changes in a worktree do not affect live settings
linked to another checkout. Review and integrate them into that checkout before
reloading; do not install from a temporary worktree. Settings changes may require
a reload/restart.
Codex's [configuration documentation](https://learn.chatgpt.com/docs/config-file/config-basic)
describes its user config file.

## Recovery and tool-managed writes

The initial migration keeps a private backup under
`~/.local/state/agent-setup-backups/` (including a manifest). Restore only reviewed
paths rather than overwriting newer settings. Backups are outside this repository.

Preserve the `CODEGRAPH_START` / `CODEGRAPH_END` block. CodeGraph installers and
other tools may replace a symlink by atomically renaming a new file over it.
After upgrades, inspect the native entry points, merge reviewed changes into the
repository, and restore links with `make install_agents`. Check `git diff` after
apps change linked settings; do not commit credentials or generated account state.

Live links refer to the checkout where installation ran. Before archiving or
deleting a worktree, install again from the permanent checkout containing these
changes. Git-tracked files alone do not preserve a deleted symlink target.
