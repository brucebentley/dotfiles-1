#!/usr/bin/bash
stat=$(cmus-remote -Q 2> /dev/null | grep status | cut -d ' ' -f2-)
duration=$(cmus-remote -Q 2> /dev/null | grep duration | cut -d ' ' -f2-)
current=$(cmus-remote -Q 2> /dev/null | grep position | cut -d ' ' -f2-)
artist=$(cmus-remote -Q 2> /dev/null | grep ' artist ' | cut -d ' ' -f3-)
song=$(cmus-remote -Q 2> /dev/null | grep title | cut -d ' ' -f3-)
if [[ "$stat" != "" && "$artist" != "" ]]; then
  echo "$artist - $song $current / $duration "
  echo "$song"
  # if [[ "$stat" == "playing" ]]; then
  #   echo "#c6ff00"
  # else
  #   echo "#ff1111"
  # fi
fi
