#!/usr/bin/env bash
#
#
#

echo "Download and convert a YouTube video."

# Form

echo -n "URL: "
read -r url

echo -n "Title: "
read -r title

echo -n "Artist: "
read -r artist

echo -n "Album: "
read -r album

echo -n "Album artist: "
read -r album_artist

file_name="$HOME/Music/$artist - $title"

echo
echo "Downloading and converting. Please wait..."
echo


# Download audio from video URL

yt-dlp \
	--force-overwrites \
	--extract-audio \
	--format bestaudio \
	--audio-format mp3 \
	--output "$file_name.tmp.%(ext)s" \
	"$url" \
	1> /dev/null


# Add metadata

ffmpeg \
	-loglevel error \
	-y \
	-i "$file_name.tmp.mp3" \
	-metadata title="$title" \
	-metadata artist="$artist" \
	-metadata album_artist="$album_artist" \
	-metadata album="$album" \
	"$file_name.mp3" \
	1> /dev/null


# Remove temporary file

rm "$file_name.tmp.mp3"


echo "Download and conversion complete!"
echo
echo "Your music file is here: $file_name.mp3"
echo

