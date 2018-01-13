#! /bin/bash -
# color definitions

########################################
#         COLOR DEFINITIONS            #
########################################

CS='\['
CE='\]'

NC='\e[0m'

# attributes
none=00
bold=01
uscore=04
blink=05
rev=07
hide=08

# text color
black=30
red=31
green=32
yellow=33
blue=34
magenta=35
cyan=36
white=37

# pass in a color from text above
brighten() {
  echo $(( $1 + 60 ))
}

# pass in a color from text above
background() {
  echo $(( $1 + 10 ))
}

# build color string
# colorbuild color attribute
# e.g., colorbuild "$red" "$BOLD"
colorbuild() {
  echo '\e['"$2"';'"$1"'m'
}

Black="$(colorbuild "$black" "$none")"
Red="$(colorbuild "$red" "$none")"
Green="$(colorbuild "$green" "$none")"
Yellow="$(colorbuild "$yellow" "$none")"
Blue="$(colorbuild "$blue" "$none")"
Magenta="$(colorbuild "$magenta" "$none")"
Cyan="$(colorbuild "$cyan" "$none")"
White="$(colorbuild "$white" "$none")"

# bright
BBlack="$(colorbuild "$(brighten "$black")" "$none")"
BRed="$(colorbuild "$(brighten "$red")" "$none")"
BGreen="$(colorbuild "$(brighten "$green")" "$none")"
BYellow="$(colorbuild "$(brighten "$yellow")" "$none")"
BBlue="$(colorbuild "$(brighten "$blue")" "$none")"
BMagenta="$(colorbuild "$(brighten "$magenta")" "$none")"
BCyan="$(colorbuild "$(brighten "$cyan")" "$none")"
BWhite="$(colorbuild "$(brighten "$white")" "$none")"

# background
On_Black="$(colorbuild "$(background "$black")" "$none")"
On_Red="$(colorbuild "$(background "$red")" "$none")"
On_Green="$(colorbuild "$(background "$green")" "$none")"
On_Yellow="$(colorbuild "$(background "$yellow")" "$none")"
On_Blue="$(colorbuild "$(background "$blue")" "$none")"
On_Magenta="$(colorbuild "$(background "$magenta")" "$none")"
On_Cyan="$(colorbuild "$(background "$cyan")" "$none")"
On_White="$(colorbuild "$(background "$white")" "$none")"

# bright background
On_BBlack="$(colorbuild "$(background "$(brighten "$black")")" "$none")"
On_BRed="$(colorbuild "$(background "$(brighten "$red")")" "$none")"
On_BGreen="$(colorbuild "$(background "$(brighten "$green")")" "$none")"
On_BYellow="$(colorbuild "$(background "$(brighten "$yellow")")" "$none")"
On_BBlue="$(colorbuild "$(background "$(brighten "$blue")")" "$none")"
On_BMagenta="$(colorbuild "$(background "$(brighten "$magenta")")" "$none")"
On_BCyan="$(colorbuild "$(background "$(brighten "$cyan")")" "$none")"
On_BWhite="$(colorbuild "$(background "$(brighten "$white")")" "$none")"
