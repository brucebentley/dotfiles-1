#!/usr/bin/env zsh

function jump() {
	emulate -L zsh

	local DIR="${*%%/}"
	cd ~"$DIR"
}

function scratch() {
	local SCRATCH=$(mktemp -d)
	echo 'Spawing subshell in scratch directory:'
	echo "  $SCRATCH"
	(cd $SCRATCH; zsh)
	echo "Removing scratch directory"
	rm -rf "$SCRATCH"
}
