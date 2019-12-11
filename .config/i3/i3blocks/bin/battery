#!/usr/bin/bash
charge=$(acpi -b | ag -o "\d+%" | tr -d "%")
status=$(acpi -b | awk '{print $3}')
echo $charge%
echo $charge%
