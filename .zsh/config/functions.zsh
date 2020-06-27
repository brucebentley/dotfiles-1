#!/usr/bin/env zsh

function jump() {
	emulate -L zsh

	local DIR="${*%%/}"
	cd ~"$DIR"
}
