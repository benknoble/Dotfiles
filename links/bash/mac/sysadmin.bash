# Display battery info
alias battery='pmset -g batt'
# Start the screensaver
alias screensaver='open -a ScreenSaverEngine'

getip() {
  ipconfig getifaddr en0
}
