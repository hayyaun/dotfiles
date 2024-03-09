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
		nixpkgs.neofetch

	# stow (overwrite)
	stow -v -t ~ */ --adopt

	# add zsh to valid login shells
	command -v zsh | sudo tee -a /etc/shells

	# use zsh as default shell
	sudo chsh -s $(which zsh) $USER

