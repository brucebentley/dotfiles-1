#!/usr/bin/env sh

/home/emanon/.mutt/scripts/notmuch.sh

find ~/.mail/INBOX -type f -mtime -30d -exec sh -c 'cat {} | lbdb-fetchaddr' \;
