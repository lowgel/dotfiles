#!/bin/sh

echo "Enter an album/song : "
read album
echo "Enter the artist : "
read artist
echo "Fetching results..."

mkdir ~/mget_temp

id=$(yt-dlp ytsearch:"$artist $album" --get-id --no-warnings)

yt-dlp --extract-audio --audio-format opus --audio-quality 0 -P '~/mget_temp' -o '%(title)s.%(ext)s' --split-chapters youtube.com/watch?v=$id

ls ~/mget_temp

for file in ~/mget_temp/*; do
	id3v2 --artist "$artist" --album "$album" "$file"
done

mv ~/mget_temp/* ~/music/

rm -rf ~/mget_temp
