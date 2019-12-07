# gem path
pathadd_front /usr/local/lib/ruby/gems/2.6.0/bin

# ruby path
pathadd_front /usr/local/opt/ruby/bin

SMLNJ=/usr/local/smlnj/bin
pathadd "$SMLNJ"
unset SMLNJ

texpath=/usr/local/texlive/2019
if [[ -d "$texpath" ]]; then
  tex_path_fix() {
    local type="$1"
    local path="${!type}"
    local prepend="$2"
    case "$path" in
      *"$prepend"* ) true ;;
      * ) eval export "$type=$prepend:$path" ;;
    esac
  }
  tex_path_fix MANPATH "$texpath"/texmf-dist/doc/man
  tex_path_fix INFOPATH "$texpath"/texmf-dist/doc/info
  tex_path_fix PATH "$texpath"/bin/x86_64-darwinlegacy
  unset tex_path_fix
fi
unset texpath

pathadd_front /Applications/MacVim.app/Contents/bin
