#!/bin/bash
stat=$(cmus-remote -Q 2> /dev/null | ag status | cut -d ' ' -f2-)
duration=$(cmus-remote -Q 2> /dev/null | ag duration | cut -d ' ' -f2-)
current=$(cmus-remote -Q 2> /dev/null | ag position | cut -d ' ' -f2-)
artist=$(cmus-remote -Q 2> /dev/null | ag ' artist ' | cut -d ' ' -f3-)
song=$(cmus-remote -Q 2> /dev/null | ag title | cut -d ' ' -f3-)
echo "$artist - $song $current / $duration "
