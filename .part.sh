#! /bin/bash

#default case (splits video into 2 parts)
parts=2

#checks if another parts value has been passed
if [ $# -gt 1 ]; then
    parts=$1
    vid=$2
else
    vid=$1
fi

#gets each part length
length=$(ffprobe -i $vid -show_entries format=duration -v quiet -of csv="p=0")
#round up
length=$(echo "$length + 1.0" | bc)

part_length=$(bc <<< $length/$parts)

#makes a directory for files
new_name=${vid%%.*}
mkdir $new_name 

#converts
#yes i know ffmpeg has a native segment function, but this works better, (trust me bro)
start=0

for((x=0; x<$parts-1; x++))
do
ffmpeg -ss $start -i $vid -c:v libvpx-vp9 -b:v "(4 - ($part_length/32))*1024*8*1000/$part_length" -t $part_length -pass 1 -y ./"$new_name"/"$new_name"_$x.webm

ffmpeg -ss $start -i $vid -c:v libvpx-vp9 -b:v "(4 - ($part_length/32))*1024*8*1000/$part_length" -t $part_length -pass 2 -y ./"$new_name"/"$new_name"_$x.webm
start=$((start+$part_length))
done

#final part (no stop, goes to end of the video)
ffmpeg -ss $start -i $vid -c:v libvpx-vp9 -b:v "(4 - ($part_length/32))*1024*8*1000/$part_length" -pass 1 -y ./"$new_name"/"$new_name"_$x.webm

ffmpeg -ss $start -i $vid -c:v libvpx-vp9 -b:v "(4 - ($part_length/32))*1024*8*1000/$part_length" -pass 2 -y ./"$new_name"/"$new_name"_$x.webm









