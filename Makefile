SOURCE		:= $(CURDIR)
TARGET		:= $(HOME)

FILES		:= gitconfig gitignore gitignore_global vimrc zshrc zprofile aliases.sh

# source=destination, relative to this checkout and TARGET respectively.
AGENT_LINKS := AGENTS.md=.agents/AGENTS.md agents/README.md=.agents/README.md \
	agents/RTK.md=.codex/RTK.md agents/codex/hooks.json=.codex/hooks.json \
	agents/claude/settings.json=.claude/settings.json agents/gemini/settings.json=.gemini/settings.json \
	agents/opencode/cli.json=.config/opencode/cli.json \
	agents/cursor/hooks.json=.cursor/hooks.json agents/cursor/mcp.json=.cursor/mcp.json \
	agents/paseo/config.json=.paseo/config.json \
	agents/paseo/plugin-settings/better-paseo/presentation.json=.paseo/plugin-settings/better-paseo/presentation.json \
	agents/paseo/plugin-settings/keep-awake/keep-awake.json=.paseo/plugin-settings/keep-awake/keep-awake.json
AGENT_LINKS += $(foreach skill,$(notdir $(wildcard $(SOURCE)/agents/skills/*)),agents/skills/$(skill)=.agents/skills/$(skill))
CLAUDE_SKILLS := paseo-loop
AGENT_NATIVE_PATHS := .claude/CLAUDE.md .gemini/GEMINI.md .codex/AGENTS.md .config/opencode/AGENTS.md \
	$(addprefix .claude/skills/,$(CLAUDE_SKILLS))

.PHONY: install_agents

UNAME		:= $(shell uname)

all: clean install

install_dependencies:
	homebrew_installer="$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
	/bin/bash -c "$$homebrew_installer"
	brew install thefuck rbenv zsh pyenv pyenv-virtualenv
	if [ ! -d "$${ZSH:-$$HOME/.oh-my-zsh}" ]; then \
		ohmyzsh_installer="$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
		sh -c "$$ohmyzsh_installer" "" --unattended --keep-zshrc; \
	fi
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	mkdir -p ~/.vim/autoload ~/.vim/bundle
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

install_dotfiles: install_agents
	for f in $(FILES); do \
		ln -sf $(SOURCE)/$$f $(TARGET)/.$$f; \
	done
	ln -sf $(SOURCE)/bin $(TARGET)/

# Refuse to overwrite local files or real skill directories. Back them up first.
install_agents:
	@set -eu; \
	for pair in $(AGENT_LINKS) $(addprefix native=,$(AGENT_NATIVE_PATHS)); do \
		path="$(TARGET)/$${pair#*=}"; \
		if [ -e "$$path" ] && [ ! -L "$$path" ]; then \
			printf 'Back up and move aside %s before installing.\n' "$$path" >&2; exit 1; \
		fi; \
	done; \
	for pair in $(AGENT_LINKS); do \
		path="$(TARGET)/$${pair#*=}"; \
		mkdir -p "$$(dirname "$$path")"; \
		ln -sfn "$(SOURCE)/$${pair%%=*}" "$$path"; \
	done
	mkdir -p "$(TARGET)/.claude" "$(TARGET)/.gemini" "$(TARGET)/.codex" "$(TARGET)/.config/opencode"
	ln -sfn ../.agents/AGENTS.md "$(TARGET)/.claude/CLAUDE.md"
	ln -sfn ../.agents/AGENTS.md "$(TARGET)/.gemini/GEMINI.md"
	ln -sfn ../.agents/AGENTS.md "$(TARGET)/.codex/AGENTS.md"
	ln -sfn ../../.agents/AGENTS.md "$(TARGET)/.config/opencode/AGENTS.md"
	@for skill in $(CLAUDE_SKILLS); do \
		mkdir -p "$(TARGET)/.claude/skills"; \
		ln -sfn "../../.agents/skills/$$skill" "$(TARGET)/.claude/skills/$$skill"; \
	done

clean_dirs:
	# Nothing to clean atm

clean_dotfiles:
	for file in $(FILES); do \
		path="$(TARGET)/.$$file"; \
		rm -f "$$path"; \
	done
	rm -f $(TARGET)/bin

install: 
	$(MAKE) install_dependencies
	$(MAKE) install_dotfiles

clean: 
	$(MAKE) clean_dirs
	$(MAKE) clean_dotfiles
