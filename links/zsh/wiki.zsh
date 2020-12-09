wiki() {
  case $# in
    0) vim +'call feedkeys(":Ewiki ")' ;;
    1) vim +"Ewiki $1" ;;
    *) printf '%s\n' 'usage: wiki [wiki]' '' 'opens a wiki entry, or prompts for one'
  esac
}

wikis() {
  rg "$@" ~/.wiki
}
