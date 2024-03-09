stow:
	stow -v -t ~ */

force-stow:
	stow -v -t ~ */ --adopt

init:
	echo "nothing to do yet"
	# install nix with curl
	# install following packages with nix:
	# git, nvim, tmux, zsh, oh-my-zsh, nitrogen
	# optional: neofetch, obsidian
