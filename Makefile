SOURCE		:= $(CURDIR)
TARGET		:= $(HOME)

FILES		:= gitconfig gitignore gitignore_global vimrc zshrc zprofile aliases.sh

UNAME		:= $(shell uname)

all: clean install

install_dependencies:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install thefuck rbenv zsh pyenv pyenv-virtualenv
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

install_dotfiles:
	for f in $(FILES); do \
		ln -sf $(SOURCE)/$$f $(TARGET)/.$$f; \
	done
	ln -sf $(SOURCE)/bin $(TARGET)/
	mkdir -p ~/.ssh/
	chmod 700 ~/.ssh/
	ln -sf $(SOURCE)/sshrc ~/.ssh/rc
	ln -sf ~/.vim/vimrc ~/.vimrc
	ln -sf ~/.vim/gvimrc ~/.gvimrc

clean_dirs:
	# Nothing to clean atm

clean_dotfiles:
	for file in $(FILES); do \
		path="$(TARGET)/.$$file"; \
		rm -f "$$path"; \
	done
	rm -f $(TARGET)/.ssh/rc
	rm -f $(TARGET)/bin

install: 
	$(MAKE) install_dependencies
	$(MAKE) install_dotfiles

clean: 
	$(MAKE) clean_dirs
	$(MAKE) clean_dotfiles
