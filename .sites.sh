#!/bin/sh

selected_item=$(cat ~/.dotfiles/.coolsites.txt | dmenu -sb '#336600' -fn 'monospace-20' -l 5 -p "cool sites")

if [[ $selected_item == "" ]]; then
	exit
fi

librewolf $selected_item
