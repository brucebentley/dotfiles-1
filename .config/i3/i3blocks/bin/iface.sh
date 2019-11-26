#!/usr/bin/env bash

################################################################################
#
# CUSTOM PLUGIN SECTION
#
################################################################################

############################################################
# Variables
############################################################

### Custom Defines
appname="iface"

if [[ -n ${BLOCK_INSTANCE} ]]; then
  iface="${BLOCK_INSTANCE}"
else
  iface="$( ip route | awk '/^default/ { print $5 ; exit }' )"
fi

format="{status_or_ip}"


### Thresholds

# Enable
has_threshold=1

# Depending on the conditions in your custom_action()
# you can force the output to be critical or warning
# Set these vars to 1 (in custom_action)
force_crit=0
force_warn=0
force_good=0


### Additional arguments
arg_params=(
"-i"
)
arg_vars=(
"iface"
)
arg_desc_val=(
"<iface>"
)
arg_desc_long=(
"Specify the network interface"
)


### Format placeholders

# bash variable names
format_vars=(
"ip"
"ip_nm"
"ip6"
"ip6_nm"
"mac"
"mtu"
"iface"
"status"
"status_or_ip"
"status_or_ip6"
)

# Format placeholders
format_nodes=(
"{ip}"
"{ip_nm}"
"{ip6}"
"{ip6_nm}"
"{mac}"
"{mtu}"
"{iface}"
"{status}"
"{status_or_ip}"
"{status_or_ip6}"
)

# Format description (for help display)
format_descs=(
"IPv4 address"
"IPv4 address including netmask"
"IPv6 address"
"IPv6 address including netmask"
"MAC address"
"MTU value"
"Network interface"
"Status (up, down, unknown, none)"
"Status text if not up or IPv4 address"
"Status text if not up or IPv6 address"
)

# Format examples (for help display)
format_examples=(
"-f \" {status}: {ip6} {mtu}\""
"-f \" {iface}: {status_or_ip6} {mac}\""
)


############################################################
# custom_actio function
############################################################

### Evaluate disk space
custom_action() {
  if ! command -v ip > /dev/null 2>&1; then
    echo "Error, ip binary not found, but required"
    exit 1
  fi

  local _output

  ip=
  ip_nm=
  ip6=
  ip6_nm=
  mac=
  mtu=
  status="unknown"
  status_or_ip="${status}"
  status_or_ip6="${status}"

  if [ ! -d "/sys/class/net/${iface}/" ] || [ ! -f "/sys/class/net/${iface}/operstate" ]; then

    status="none"
    status_or_ip="${status}"
    status_or_ip6="${status}"
    force_crit=1

  else

    _output="$( ip addr show "${iface}" 2>/dev/null )"

    ip="$(     echo "${_output}" | rg -oe '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1 )"
    ip_nm="$(  echo "${_output}" | rg -oe '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+' | head -1 )"
    ip6="$(    echo "${_output}" | rg -oe 'inet6' | rg -oe '[0-9a-fA-F]*::.*/[0-9]+' | sed 's/\/.*//g' )"
    ip6_nm="$( echo "${_output}" | rg -oe 'inet6' | rg -oe '[0-9a-fA-F]*::.*/[0-9]+' )"
    mac="$(    echo "${_output}" | rg 'link/' | rg -oe '([0-9a-fA-F]{2}:)+[0-9a-fA-F]{2}' | head -1 )"
    mtu="$(    echo "${_output}" | rg -oe 'mtu\s*[0-9]+' | sed 's/mtu\s//g' )"

    if [ "$( cat "/sys/class/net/${iface}/operstate" )" = "down" ]; then
      status="down"
      status_or_ip="${status}"
      status_or_ip6="${status}"
      force_crit=1
    else
      status="up"
      status_or_ip="${ip}"
      status_or_ip6="${ip6}"
      force_good=1
    fi
  fi
}

################################################################################
#
# BUILT-IN VARIABLES
#
################################################################################

### Extended format arrays
fe_placeholder=()
fe_sign=()
fe_value=()
fe_format=()


### Threshold arrays
tg_placeholder=()
tg_sign=()
tg_value=()

ti_placeholder=()
ti_sign=()
ti_value=()

tw_placeholder=()
tw_sign=()
tw_value=()

tc_placeholder=()
tc_sign=()
tc_value=()


### Use of pango markup?
pango=1

################################################################################
#
# BUILT-IN FUNCTIONS
#
################################################################################

### Replace custom stuff in format string
replace_placeholders() {
  local _format="${1}"
  local _search
  local _replace

  # Select format based on extended placeholders
  for (( i=0; i < ${#fe_placeholder[@]}; i++ )); do

    if [ "${fe_sign[$i]}" = "=" ] || [ "${fe_sign[$i]}" = "!=" ]; then
      pval="${!fe_placeholder[$i]}"
    else
      pval="$( echo "${!fe_placeholder[$i]}" | rg -oe '[0-9]*' | head -1 )"
    fi

    if [ "${fe_sign[$i]}" = "<" ]; then
      if [ "${pval}" -lt "${fe_value[$i]}" ]; then
        _format="${fe_format[$i]}"
      fi
    elif [ "${fe_sign[$i]}" = "=" ]; then
      if [[ "${pval}" =~ ${fe_value[$i]} ]]; then
        _format="${fe_format[$i]}"
      fi
    elif [ "${fe_sign[$i]}" = "!=" ]; then
      if [[ "${pval}" != ${fe_value[$i]} ]]; then
        _format="${fe_format[$i]}"
      fi
    elif [ "${fe_sign[$i]}" = ">" ]; then
      if [ "${pval}" -gt "${fe_value[$i]}" ]; then
        _format="${fe_format[$i]}"
      fi
    fi
  done



  # Replace placeholders in $format
  for (( i=0; i < ${#format_nodes[@]}; i++ )); do
    _search="${format_nodes[$i]}"
    _replace="${!format_vars[$i]}"
    _format="${_format/${_search}/${_replace}}"
  done
  echo "${_format}"
}

### Replace colors in format string
replace_colors() {
  local _format="${1}"
  local _color="${2}"
  local _color_def="${3}"
  local _color_good="${4}"
  local _color_warn="${5}"
  local _color_crit="${6}"
  local _color_info="${7}"

  _format="${_format/'{color}'/${_color}}"
  _format="${_format/'{color_def}'/${_color_def}}"
  _format="${_format/'{color_good}'/${_color_good}}"
  _format="${_format/'{color_warn}'/${_color_warn}}"
  _format="${_format/'{color_crit}'/${_color_crit}}"
  _format="${_format/'{color_info}'/${_color_info}}"

  echo "${_format}"
}



################################################################################
#
# MAIN ENTRY POINT
#
################################################################################

# Enable/Disable threshold argument
if [ "${has_threshold}" = "1" ]; then
  th_chk=""
else
  th_chk="__THRESHOLD_DISABLED__"
fi


while [ $# -gt 0  ]; do
  case "$1" in
    ### Extended formats
    -fe)
    # 1/4 Check placeholder
    shift
    if [ "${1}" = "" ]; then
      echo "Error, -fe <p> - no placeholder specified."
      echo "Type ${appname} -h for help"
      exit 1
    fi
    f=0
    for (( i=0; i < ${#format_nodes[@]}; i++ )); do
      if [ "${format_nodes[$i]}" = "${1}" ]; then
        f=1
        break
      fi
    done
    if [ "${f}" = "0" ]; then
      echo "Error, -fe '${1}' no such placeholder."
      echo "Type ${appname} -h for help"
      exit 1
    fi
    fe_placeholder+=("${format_vars[$i]}")

      # 2/4 Check sign
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -fe '{${fe_placeholder[${#fe_placeholder[@]}-1]}}' '${1}' - sign argyment is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${1}" != "<" ] && [ "${1}" != ">" ] && [ "${1}" != "=" ] && [ "${1}" != "!=" ]; then
        echo "Error, -fe '{${fe_placeholder[${#fe_placeholder[@]}-1]}}' '${1}' - invalid sign: '${1}'."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      fe_sign+=("${1}")

      # 3/4 Check value
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -fe '{${fe_placeholder[${#fe_placeholder[@]}-1]}}' '${fe_sign[${#fe_sign[@]}-1]}' '${1}' - value argument is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${fe_sign[${#fe_sign[@]}-1]}" = ">" ] || [ "${fe_sign[${#fe_sign[@]}-1]}" = "<" ]; then
        if ! printf "%d" "${1}" >/dev/null 2>&1; then
          echo "Error, -fe '{${fe_placeholder[${#fe_placeholder[@]}-1]}}' '${fe_sign[${#fe_sign[@]}-1]}' '${1}' - value argument is not a number."
          echo "Type ${appname} -h for help"
          exit 1
        fi
      fi
      fe_value+=("${1}")

      # 4/4 Check placeholder string
      shift
      fe_format+=("${1}")
      ;;
      ### Threshold good
      -tg${th_chk})
      # 1/3 Check placeholder
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tg <p> - no placeholder specified."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      f=0
      for (( i=0; i < ${#format_nodes[@]}; i++ )); do
        if [ "${format_nodes[$i]}" = "${1}" ]; then
          f=1
          break
        fi
      done
      if [ "${f}" = "0" ]; then
        echo "Error, -tg '${1}' no such placeholder."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      tg_placeholder+=("${format_vars[$i]}")

      # 2/3 Check sign
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tg '{${tg_placeholder[${#tg_placeholder[@]}-1]}}' '${1}' - sign argument is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${1}" != "<" ] && [ "${1}" != ">" ] && [ "${1}" != "=" ] && [ "${1}" != "!=" ]; then
        echo "Error, -tg '{${tg_placeholder[${#tg_placeholder[@]}-1]}}' '${1}' - invalid sign: '${1}'."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      tg_sign+=("${1}")

      # 3/3 Check value
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tg '{${tg_placeholder[${#tg_placeholder[@]}-1]}}' '${tg_sign[${#tg_sign[@]}-1]}' '${1}' - value argyment is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${tg_sign[${#tg_sign[@]}-1]}" = ">" ] || [ "${tg_sign[${#tg_sign[@]}-1]}" = "<" ]; then
        if ! printf "%d" "${1}" >/dev/null 2>&1; then
          echo "Error, -tg '{${tg_placeholder[${#tg_placeholder[@]}-1]}}' '${tg_sign[${#tg_sign[@]}-1]}' '${1}' - value argument is not a number."
          echo "Type ${appname} -h for help"
          exit 1
        fi
      fi
      tg_value+=("${1}")
      ;;
      ### Threshold info
      -ti${th_chk})
      # 1/3 Check placeholder
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -ti <p> - no placeholder specified."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      f=0
      for (( i=0; i < ${#format_nodes[@]}; i++ )); do
        if [ "${format_nodes[$i]}" = "${1}" ]; then
          f=1
          break
        fi
      done
      if [ "${f}" = "0" ]; then
        echo "Error, -ti '${1}' no such placeholder."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      ti_placeholder+=("${format_vars[$i]}")

      # 2/3 Check sign
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -ti '{${ti_placeholder[${#ti_placeholder[@]}-1]}}' '${1}' - sign argument is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${1}" != "<" ] && [ "${1}" != ">" ] && [ "${1}" != "=" ] && [ "${1}" != "!=" ]; then
        echo "Error, -ti '{${ti_placeholder[${#ti_placeholder[@]}-1]}}' '${1}' - invalid sign: '${1}'."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      ti_sign+=("${1}")

      # 3/3 Check value
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -ti '{${ti_placeholder[${#ti_placeholder[@]}-1]}}' '${ti_sign[${#ti_sign[@]}-1]}' '${1}' - value argyment is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${ti_sign[${#ti_sign[@]}-1]}" = ">" ] || [ "${ti_sign[${#ti_sign[@]}-1]}" = "<" ]; then
        if ! printf "%d" "${1}" >/dev/null 2>&1; then
          echo "Error, -ti '{${ti_placeholder[${#ti_placeholder[@]}-1]}}' '${ti_sign[${#ti_sign[@]}-1]}' '${1}' - value argument is not a number."
          echo "Type ${appname} -h for help"
          exit 1
        fi
      fi
      ti_value+=("${1}")
      ;;
      ### Threshold warning
      -tw${th_chk})
      # 1/3 Check placeholder
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tw <p> - no placeholder specified."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      f=0
      for (( i=0; i < ${#format_nodes[@]}; i++ )); do
        if [ "${format_nodes[$i]}" = "${1}" ]; then
          f=1
          break
        fi
      done
      if [ "${f}" = "0" ]; then
        echo "Error, -tw '${1}' no such placeholder."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      tw_placeholder+=("${format_vars[$i]}")

      # 2/3 Check sign
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tw '{${tw_placeholder[${#tw_placeholder[@]}-1]}}' '${1}' - sign argument is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${1}" != "<" ] && [ "${1}" != ">" ] && [ "${1}" != "=" ] && [ "${1}" != "!=" ]; then
        echo "Error, -tw '{${tw_placeholder[${#tw_placeholder[@]}-1]}}' '${1}' - invalid sign: '${1}'."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      tw_sign+=("${1}")

      # 3/3 Check value
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tw '{${tw_placeholder[${#tw_placeholder[@]}-1]}}' '${tw_sign[${#tw_sign[@]}-1]}' '${1}' - value argyment is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${tw_sign[${#tw_sign[@]}-1]}" = ">" ] || [ "${tw_sign[${#tw_sign[@]}-1]}" = "<" ]; then
        if ! printf "%d" "${1}" >/dev/null 2>&1; then
          echo "Error, -tw '{${tw_placeholder[${#tw_placeholder[@]}-1]}}' '${tw_sign[${#tw_sign[@]}-1]}' '${1}' - value argument is not a number."
          echo "Type ${appname} -h for help"
          exit 1
        fi
      fi
      tw_value+=("${1}")
      ;;
      ### Threshold critical
      -tc${th_chk})
      # 1/3 Check placeholder
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tc <p> - no placeholder specified."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      f=0
      for (( i=0; i < ${#format_nodes[@]}; i++ )); do
        if [ "${format_nodes[$i]}" = "${1}" ]; then
          f=1
          break
        fi
      done
      if [ "${f}" = "0" ]; then
        echo "Error, -tc '${1}' no such placeholder."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      tc_placeholder+=("${format_vars[$i]}")

      # 2/3 Check sign
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tc '{${tc_placeholder[${#tc_placeholder[@]}-1]}}' '${1}' - sign argument is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${1}" != "<" ] && [ "${1}" != ">" ] && [ "${1}" != "=" ] && [ "${1}" != "!=" ]; then
        echo "Error, -tc '{${tc_placeholder[${#tc_placeholder[@]}-1]}}' '${1}' - invalid sign: '${1}'."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      tc_sign+=("${1}")

      # 3/3 Check value
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -tc '{${tc_placeholder[${#tc_placeholder[@]}-1]}}' '${tc_sign[${#tc_sign[@]}-1]}' '${1}' - value argyment is empty."
        echo "Type ${appname} -h for help"
        exit 1
      fi
      if [ "${tc_sign[${#tc_sign[@]}-1]}" = ">" ] || [ "${tc_sign[${#tc_sign[@]}-1]}" = "<" ]; then
        if ! printf "%d" "${1}" >/dev/null 2>&1; then
          echo "Error, -tc '{${tc_placeholder[${#tc_placeholder[@]}-1]}}' '${tc_sign[${#tc_sign[@]}-1]}' '${1}' - value argument is not a number."
          echo "Type ${appname} -h for help"
          exit 1
        fi
      fi
      tc_value+=("${1}")
      ;;
      ### Format overwrite
      -f)
      shift
      if [ "${1}" = "" ]; then
        echo "Error, -f requires a string"
        echo "Type ${appname} -h for help"
        exit 1
      fi
      format="${1}"
      ;;
      ### Disable pango markup output
      -np)
      pango=0
      ;;
      ### Color overwrites
      -cd)
      # default color
      shift
      if ! echo "${1}" | rg -qe '#[0-9a-fA-F]{6}' >/dev/null 2>&1; then
        echo "Error, invalid color string: ${1}"
        echo "Type ${appname} -h for help"
        exit 1
      fi
      color_def="${1}"
      ;;
    -cg)
      # good color
      shift
      if ! echo "${1}" | rg -qe '#[0-9a-fA-F]{6}' >/dev/null 2>&1; then
        echo "Error, invalid color string: ${1}"
        echo "Type ${appname} -h for help"
        exit 1
      fi
      color_good="${1}"
      ;;
    -cw)
      # warning color
      shift
      if ! echo "${1}" | rg -qe '#[0-9a-fA-F]{6}' >/dev/null 2>&1; then
        echo "Error, invalid color string: ${1}"
        echo "Type ${appname} -h for help"
        exit 1
      fi
      color_warn="${1}"
      ;;
    -cc)
      # critical color
      shift
      if ! echo "${1}" | rg -qe '#[0-9a-fA-F]{6}' >/dev/null 2>&1; then
        echo "Error, invalid color string: ${1}"
        echo "Type ${appname} -h for help"
        exit 1
      fi
      color_crit="${1}"
      ;;
    -ci)
      # info color
      shift
      if ! echo "${1}" | rg -qe '#[0-9a-fA-F]{6}' >/dev/null 2>&1; then
        echo "Error, invalid color string: ${1}"
        echo "Type ${appname} -h for help"
        exit 1
      fi
      color_info="${1}"
      ;;
      ### System options
      -h)
      print_usage
      exit 0
      ;;
    -v)
      print_version
      exit 0
      ;;
      ### Unknown/Custom option
      *)

      ### Evaluate user-specified arguments
      found=0
      if [ "${#arg_params}" -gt "0" ]; then
        for (( i=0; i<${#arg_params[@]}; i++ )); do
          if [ "${arg_params[$i]}" = "${1}" ]; then
            shift
            var_name="${arg_vars[$i]}"
            eval "${var_name}=\"${1}\""
            found=1
            break;
          fi
        done
      fi

      ### Unknown option
      if [ "${found}" = "0" ]; then
        echo "Invalid argument: '${1}'"
        echo "Type ${appname} -h for help"
        exit 1
      fi
      ;;
  esac
  shift
done

### Call custom function
custom_action

### Get final output color (based on custom specs)
color="$( get_status_color "${color_def}" "${color_good}" "${color_warn}" "${color_crit}" "${color_info}" )"

### Format (colors)
format="$( replace_colors "${format}" "${color}" "${color_def}" "${color_good}" "${color_warn}" "${color_crit}" "${color_info}" )"

### Format (custom)
format="$( replace_placeholders "${format}" )"


### Output pango or plain style?
if [ "${pango}" = "1" ]; then
  if [ "${format}" != "" ]; then
    echo "${format} "
  fi
else
  echo "${format} "	# Long output
  echo "${format} "	# short output
fi

exit 0
