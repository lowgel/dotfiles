#!/bin/sh

filetype="$(file -b "$1")"

case "$filetype" in
	#executables files
	*ELF*)
		"$1"
	;;
	#compressed files
	*gzip*)
		tar -xvzf "$1"
	;;
	*Zip*)
		unzip "$1"
	;;
	#documents
	*PDF*)
		zathura "$1"
	;;
	#videos
	*Matroska*)
		mpv --fullscreen "$1"
	
	;;
	*MP4*)
		mpv --fullscreen "$1"
	;;
	*WebM*)
		mpv --fullscreen "$1"
	;;
	#music
	*Opus*)
		mpc "$1"
	;;
	#images
	*image*)	
		feh --fullscreen --randomize --start-at "$1" 
	;;
	*PNG*)	
		feh --fullscreen --randomize --start-at "$1" 
	;;
	*HTML*)
		librewolf "$1"
	;;
	#base case (text document)
	*)
		vim "$1"
	;;
esac

