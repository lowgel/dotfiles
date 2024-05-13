#!/bin/sh

for x in *
do
	filename=$(file "$x" | grep -e "PNG" -e "JPEG" -e "JPG" | awk -F: '{print $1}')
	echo "$filename"

done	
