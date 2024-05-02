#!/bin/sh

filetype="$(file -b "$1")"

case "$filetype" in
	#documents
	*PDF*)
		zathura "$1"
	;;
	#videos
	*MP4*)
		mpv "$1"
	;;
	*WebM*)
		mpv "$1"
	;;
	#music
	*Opus*)
		mpc "$1"
	;;
	#images
	*image*)	
		feh -F "$1"
	;;
	#base case (text document)
	*)
		nvim "$1"
	;;
esac

