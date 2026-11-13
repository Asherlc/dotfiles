dotfiles
========
This is my personal collection of dotfiles for various shells and tools.

Usage
=====
Clone the repository:

    git clone https://github.com/asherlc/dotfiles.git

Install dependencies:

    make install_dependencies

Create symlinks (will overwrite existing files):

    make install

Agent configuration
===================

Shared instructions, personal skills, reviewed provider settings, and global
Paseo configuration are versioned here. To install just their symlinks:

    make install_agents

See [agents/README.md](agents/README.md) for backups, machine-specific dependencies,
credential-safe examples, and worktree lifetime considerations.


