#! /bin/bash

# Change current working directory
cd "/home/moonmoon/AllVideosAlbertson/Group/Cropped/"

# Set static variables (duration and slider allow for overlapping segments when necessary) in seconds
duration=14400
slider=14400

# Loop through all files with extension matching .avi; then execute the following commands
for i in *.avi; do 
    # Set static start to reset at the beginning of each video
    start=0
    # Suppress longform output and read file name with ffprobe
    ffprobe -i "$i" -hide_banner -v error -show_entries format=duration -of flat
    # Create folder for filename if one does not already exist
    foldername=`basename -- "$i" .avi`

    mkdir -p /home/moonmoon/AllVideosAlbertson/Group/ToTrack/$foldername;
    # Run loop to create each video cut for n in a sequence of *six*; then execute the following lines
    for n in `seq 6`; do 
        # Cut the video at the checkpoints designated by the static variables, copy audio/video codecs and set name 
        ffmpeg -i "$i" -ss $start -t $duration -c:v copy -c:a copy /home/moonmoon/AllVideosAlbertson/Group/ToTrack/$foldername/cut"$n"-"$i"
        # Print progress using static variable
        #echo $start
        #echo $slider
        # Override start to equal the position at the end of the current cut
        start=$(($start+$slider))
        # Print start to verify success
        #echo $start
    # End inner for loop
    done
    mv /home/moonmoon/AllVideosAlbertson/Group/Cropped/$i /home/moonmoon/AllVideosAlbertson/Group/Originals/$i
# End outer for loop
done
