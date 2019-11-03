#!/usr/bin/bash
charge=$(acpi -b | ag -o "\d+%" | tr -d "%")
status=$(acpi -b | awk '{print $3}')
echo $charge%
echo $charge%
if [[ $status == Dis* ]];
then
  if [[ $charge -lt 20 ]];
  then
    echo "#FB4934"
  fi
fi
