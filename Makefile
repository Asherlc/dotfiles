SOURCE		:= $(CURDIR)
TARGET		:= $(HOME)

FILES		:= gitconfig gitignore gitignore_global vimrc bashrc bash_profile 

UNAME		:= $(shell uname)

all: clean install

install_dotfiles:
	@for f in $(FILES); do \
		ln -sf $(SOURCE)/$$f $(TARGET)/.$$f; \
	done
	@ln -sf $(SOURCE)/bin $(TARGET)/
	@mkdir -p ~/.ssh/
	@chmod 700 ~/.ssh/
	@ln -sf $(SOURCE)/sshrc ~/.ssh/rc
	@ln -s ~/.vim/vimrc ~/.vimrc
	@ln -s ~/.vim/gvimrc ~/.gvimrc

clean_dotfiles:
	@-for f in $(FILES); do \
		unlink $(TARGET)/.$$f; \
	done
	@-unlink $(TARGET)/.ssh/rc
	@-unlink $(TARGET)/bin

install: install_dotfiles

clean: clean_dotfiles
