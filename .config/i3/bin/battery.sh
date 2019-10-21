#!/usr/bin/bash
charge=$(acpi -b | rg -o "\d+%" | tr -d "%")
status=$(acpi -b | awk '{print $3}')
echo $charge%
echo $charge%
