#!/usr/bin/env zsh

jump() {
	emulate -L zsh

	local DIR="${*%%/}"
	cd ~"$DIR"
}

scratch() {
	local SCRATCH=$(mktemp -d)
	echo 'Spawing subshell in scratch directory:'
	echo "  $SCRATCH"
	(cd $SCRATCH; zsh)
	echo "Removing scratch directory"
	rm -rf "$SCRATCH"
}
