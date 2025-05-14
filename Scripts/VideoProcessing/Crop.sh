#! /bin/bash

# Change current working directory
cd "/home/moonmoon/AllVideosAlbertson/Group/_Noncropped"

# Loop through all files with extension matching .avi; then execute the following commands
for i in *.avi; do 
    # Suppress longform output with ffprobe
    ffprobe -i "$i" -hide_banner -v error -show_entries format=duration -of flat
    name="${i%.*}"
    # Create cropped version of video with *MANUALLY ADJUSTED* coordinate points, set video codec to match original, copy audio codec, and set filename
    ffmpeg -i "$i" -vf "crop=286:153:14:71" -c:v h264 -c:a copy /home/moonmoon/AllVideosAlbertson/Group/Cropped/crop"$name".avi
    #ffmpeg -i "$i" -vf "crop=101:158:109:45" -c:v h264 -c:a copy /home/moonmoon/AllVideosAlbertson/Group/Cropped/crop"$name"_ind2.avi
    #ffmpeg -i "$i" -vf "crop=89:158:211:45" -c:v h264 -c:a copy /home/moonmoon/AllVideosAlbertson/Group/Cropped/crop"$name"_ind3.avi
    # Move the uncropped avi to the Originals folder
    mv "/home/moonmoon/AllVideosAlbertson/Group/_Noncropped/$i" "/home/moonmoon/AllVideosAlbertson/Group/Originals/$i"
# End loop
done


