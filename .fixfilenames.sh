#!/bin/sh


#changes all the files in a folder to my prefered naming scheme (dashes, all lowercase, no special characters)

for file in ./*; do

	if [ -d "$file" ]; then 
		continue
	fi

	clean_string=$(basename "$file")
	clean_string="${clean_string,,}"
	clean_string="${clean_string//[_ ]/-}"
	clean_string="${clean_string//[^[:alnum:].-]/}"

	mv "$file" ./$clean_string
done	


