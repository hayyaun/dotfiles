stow:
	stow -v -t ~ */

stow-force:
	stow -v -t ~ */ --adopt

init:
	# install nix with curl (multi-user)
	sh <(curl -L https://nixos.org/nix/install) --daemon
	nix --version

	# source nix
	#. ~/.nix-profiles/etc/profile.d/nix.sh

	# install following packages with nix:
	# git, nvim, tmux, zsh, oh-my-zsh, nitrogen
	# optional: neofetch, obsidian
	nix-env -iA \
		nixpkgs.zsh \
		nixpkgs.git \
		nixpkgs.tmux \
		nixpkgs.neovim \
		nixpkgs.stow \
		nixpkgs.i3 \
		nixpkgs.polybar \
		nixpkgs.picom \
		nixpkgs.nitrogen \
		nixpkgs.neofetch \
		nixpkgs.oh-my-zsh

	# stow (overwrite)
	@echo -n "Are you running this on a fresh machine? [Y/n] " && read ans && if [ $${ans:-'Y'} = 'n' ]; then \
		stow -v -t ~ */ --adopt; \
	else \
		stow -v -t ~ */; \
	fi

	# add zsh to valid login shells
	command -v zsh | sudo tee -a /etc/shells

	# use zsh as default shell
	sudo chsh -s $(which zsh) $USER

sync:
	git fetch
	git pull
	stow -v -t ~ */

