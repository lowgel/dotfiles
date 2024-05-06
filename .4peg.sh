#! /bin/bash

sound=false

convert() {
size="${#1}"
trunc_name=$1

#gets the name of the input video without file path or file type, stores in trunc_name

    for ((x = size; x > 2; x--)); do
        if [[ "${1:x:1}" = '.' ]]; then
            if [ $2 = 'd' ]; then
                trunc_name="${1:2:x - 2}" 
                trunc_name+="_4mb"
            else
                trunc_name="${1:0:x}"
                trunc_name+="_4mb"
            fi
            if [ $sound = true ]; then
                trunc_name+="_sound"
            fi
            echo $trunc_name
            break
        fi
    done

#finds video length in seconds

length=$(ffprobe -i $1 -show_entries format=duration -v quiet -of csv="p=0")

#2-pass conversion; the equation calculates the total bits allowed in the video; ($length/256) allows for codec overhead

if [ $sound = false ]; then

ffmpeg -i $1 -c:v libvpx-vp9 -b:v "(4 - ($length/256))*1024*8*1000/$length" -an -pass 1 -y $trunc_name.webm


ffmpeg -i $1 -c:v libvpx-vp9 -b:v "(4 - ($length/256))*1024*8*1000/$length" -an -pass 2 -y $trunc_name.webm
else

ffmpeg -i $1 -c:v libvpx-vp9 -b:v "(4 - ($length/64))*1024*8*1000/$length" -pass 1 -y $trunc_name.webm


ffmpeg -i $1 -c:v libvpx-vp9 -b:v "(4 - ($length/64))*1024*8*1000/$length" -pass 2 -y $trunc_name.webm

fi
}
#
#main function, iterates through all arguments
  
for vid in "$@"; do
    if [ $vid = 's' ]; then
        sound=true;
    fi
if [ -d "$vid" ]; then
    for file in "$vid"/*; do
        echo $file
        convert $file d
    done
else
    convert $vid
fi
done

