# ANSI Colours codes
#Normal
black='\e[0;30m'
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
purple='\e[0;35m'
cyan='\e[0;36m'
white='\e[0;37m'

#Bold
bBlack='\e[1;30m'
bRed='\e[1;31m'
bGreen='\e[1;32m'
bYellow='\e[1;33m'
bBlue='\e[1;34m'
bPurple='\e[1;35m'
bCyan='\e[1;36m'
bWhite='\e[1;37m'

#Underline
uBlack='\e[4;30m'
uRed='\e[4;31m'
uGreen='\e[4;32m'
uYellow='\e[4;33m'
uBlue='\e[4;34m'
uPurple='\e[4;35m'
uCyan='\e[4;36m'
uWhite='\e[4;37m'

#Background
bgBlack='\e[40m'
bgRed='\e[41m'
bgGreen='\e[42m'
bgYellow='\e[43m'
bgBlue='\e[44m'
bgPurple='\e[45m'
bgCyan='\e[46m'
bgWhite='\e[47m'

#High Intensty
hiBlack='\e[0;90m'
hiRed='\e[0;91m'
hiGreen='\e[0;92m'
hiYellow='\e[0;93m'
hiBlue='\e[0;94m'
hiPurple='\e[0;95m'
hiCyan='\e[0;96m'
hiWhite='\e[0;97m'

#Bold High Intensty
bhiBlack='\e[1;90m'
bhiRed='\e[1;91m'
bhiGreen='\e[1;92m'
bhiYellow='\e[1;93m'
bhiBlue='\e[1;94m'
bhiPurple='\e[1;95m'
bhiCyan='\e[1;96m'
bhiWhite='\e[1;97m'

#Background High Intensty
bghiBlack='\e[0;100m'
bghiRed='\e[0;101m'
bghiGreen='\e[0;102m'
bghiYellow='\e[0;103m'
bghiBlue='\e[0;104m'
bghiPurple='\e[0;105m'
bghiCyan='\e[0;106m'
bghiWhite='\e[0;107m'

resetColorCMD="/bin/tput sgr0"
resetColor="\E[m\017"

c/bin/echo() {
  # Coloured-echo
  # Argument $1 = font color
  # Argument $2 = message
  color=$1
  message=$2
  /bin/echo -e "$color$message"
  $resetColorCMD
  /bin/echo -e "$resetColor"
  return
}
