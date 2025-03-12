stow:
	stow -v -t ~ */

stow-force:
	stow -v -t ~ */ --adopt

sync:
	git fetch
	git pull
	stow -v -t ~ */
