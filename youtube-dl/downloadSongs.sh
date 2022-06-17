#!/bin/bash

# global variables
SONGS_URL_FILE=./songsDirectory/songsUrl.txt
NEED_VIDEO=false

#functions
print_new_line(){
  echo ""
}
download_mp3_from_youtube(){
  yt-dlp -f "bestaudio/best" -P "./songsDirectory/audio_only" -o "%(title)s.%(ext)s" --audio-format mp3 "$1"
}
download_video_from_youtube(){
  yt-dlp -o "./songsDirectory/video_and_audio/%(title)s.%(ext)s" -f best "$1"
}
make_all_needed_files(){
  mkdir songsDirectory  &> /dev/null
  touch "$SONGS_URL_FILE" &> /dev/null
}
make_array_from_file(){
  local -n array_of_songs=$1
  if [[ -s "$SONGS_URL_FILE" ]];
  then
    mapfile -t array_of_songs < "$SONGS_URL_FILE"
  else
    echo "SongsUrl file empty"
    exit 1
  fi
}
download_song_by_url(){
  echo "DESCARGANDO $1"
  if $NEED_VIDEO
  then 
    download_video_from_youtube "$1"
  else
    download_mp3_from_youtube "$1"
  fi
  echo "DESCARGANDO"
  print_new_line
}

download_songs_from_array(){
  local array_of_songs=("$@")
  for i in "${array_of_songs[@]}"
  do
    download_song_by_url "$i"
  done
}
verify_if_want_video(){
  print_new_line
  echo "YOU WANT DOWNLOAD WITH VIDEO ( yes/y | no/n )"
  read video_or_audio
  print_new_line
  if [[ "$video_or_audio" == "y" || "$video_or_audio" == "Y" ||"$video_or_audio" == "yes" || "$video_or_audio" == "Yes" || "$video_or_audio" == "YES" ]]
  then
    NEED_VIDEO=true
  fi
}

main(){
  local ARRAY_OF_SONGS
  make_all_needed_files
  make_array_from_file ARRAY_OF_SONGS
  verify_if_want_video
  download_songs_from_array "${ARRAY_OF_SONGS[@]}"
}

main

#while IFS="" read -r p || [ -n "$p" ]
#do
#  download_mp3_from_youtube $p &
#  #$p >> cancionesYaDescargadas.txt
#done < songsUrl.txt
#
#echo "" > songsUrl.txt
