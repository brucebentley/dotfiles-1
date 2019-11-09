#!/bin/sh

if info=$(cmus-remote -Q 2> /dev/null); then
  status=$(echo "$info" | ag -v "set " | ag -v "tag " | ag "status " | cut -d ' ' -f 2)

  if [ "$status" = "playing" ] || [ "$status" = "paused" ] || [ "$status" = "stopped" ]; then
    title=$(echo "$info" | ag -v 'set ' | ag " title " | cut -d ' ' -f 3-)
    artist=$(echo "$info" | ag -v 'set ' | ag " artist " | cut -d ' ' -f 3-)
    position=$(echo "$info" | ag -v "set " | ag -v "tag " | ag "position " | cut -d ' ' -f 2)
    duration=$(echo "$info" | ag -v "set " | ag -v "tag " | ag "duration " | cut -d ' ' -f 2)

    if [ "$duration" -ge 0 ]; then
      pos_minutes=$(printf "%02d" $((position / 60)))
      pos_seconds=$(printf "%02d" $((position % 60)))

      dur_minutes=$(printf "%02d" $((duration / 60)))
      dur_seconds=$(printf "%02d" $((duration % 60)))

      info_string=" $pos_minutes:$pos_seconds / $dur_minutes:$dur_seconds" 
    fi

    info_string="$artist - $title $info_string"
    echo "$info_string"
  else
    echo ""
  fi
else
  echo ""
fi
