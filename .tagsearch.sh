#!/bin/sh

echo "Searching..." 

print=1
matches=""

for file in *; do

#skips directories
	if [ -d "$file" ]; then
		continue
	fi

	exif=$(exiftool "$file")

#check to see if the file matches all the arguments provided
	for arg in "$@"; do
		match=$(grep -m 1 -o "$arg" "$exif")
		if [ "$match" != "$arg" ]; then
			print=0
			break;
		fi
	done


#add the filename to 'matches' if it match all the arguments
	if [ $print = 1 ]; then
		matches+="$file"
		matches+=" "
	fi
	print=1
done


feh -F $matches
