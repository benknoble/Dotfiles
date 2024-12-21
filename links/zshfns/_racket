#compdef racket raco

#
# This file defines zsh completions for `racket' and `raco'.
#
# To give it a quick try, load this file with the "source" command.
#
# The proper way to install it is to copy it to a file called "_racket" in one
# the zsh function directories which you can find with "echo $fpath".  For
# example: "cp racket-completion.zsh ${fpath[1]}/_racket".  If all of the
# $fpath entries are system directories that you can't write to, you can add
# your own path by adding something like "fpath+=~/.zsh" in your ".zshrc" file.
# You can also use "source" as described above, but then it's not auto-loaded.
# (Note that sourcing this file will load the completion system if it's not
# already done.)
#
# These completions include useful hints for flags, and for types of arguments.
# To see the latter, you can something like add the following to your ".zshrc":
#   zstyle ':completion:*' verbose yes
#   zstyle ':completion:*:descriptions' format '--- %U%d%u ---'
#
# The completions below cover all of the `racket' and `raco' commands.  It also
# includes a simple test facility: if you run "_racket --self-test", it will go
# over all --help outputs, and compare them with the outputs that were in
# effect when this script was updated.  This a simple checksum test, and
# failures are usually due to added flags and text tweaks.  (It is mostly
# useful to keep track of command-line changes between releases.)
#
# If you want to include a new raco command, you need to define a function that
# is called "_raco_cmd_<new-command>", see below for many examples.  To have
# your code autoloaded, place the function's *body* in a file that has the
# function's name, in one of the "$fpath" directories, and make sure that the
# first line is "#autoload".  (Autoloaded functions in zsh have their body
# saved in a file that has the function name.  This file uses a common trick:
# it defines the `_racket' function which zsh will not overwrite, and it calls
# the function since it's loaded on first use.)
#

# Identify zsh as the completion client
export RACKET_COMPLETION_CLIENT=zsh

###############################################################################

_racket_file_expander() {
  if [[ -d "$REPLY" ]]; then return 0
  elif [[ "$REPLY" = *.(rkt|ss) ]]; then reply="${REPLY%.*}"
  elif [[ "$REPLY" = *.(scrbl|scm) ]]; then return 0
  else return 1; fi
}

_racket_call() {
  local tag="$1"; shift; local prog="$*"
  local -a flags; local f
  flags=()
  if [[ "$service" = "racket" ]]; then
    for f in "-"{X,S,A,C,U} "--"{collects,search,addon,links,no-user-path}; do
      (( $+opt_args[$f] )) && flags+=("$f" "${opt_args[$f]}")
    done
  fi
  _call_program "$tag" racket "${(@)flags}" -I racket/base -q -e '$prog'
}

_raco_call() {
  local tag="$1"; shift
  _call_program "$tag" raco "$@"
}

_racket_read_installed_package() {
  local -a packages
  packages=(
    "${(f)$(_raco_call packages pkg show --all | sed 1,2d | awk '{print $1}' | sed 's/\*$//')}"
  )
  _wanted installed-packages expl installed-package compadd -a packages
}

_racket_read_migrate_version() {
  local -a versions
  versions=(
    "${(f)$(_racket_call migrate-versions '(require pkg/lib) (for-each displayln (pkg-migrate-available-versions))')}"
  )
  _wanted migrate-versions expl migrate-version compadd -a versions
}

_racket_read_libfile_or_collect() {
  local -a dirs
  dirs=(
    "${(f)$(_racket_call directories '(require (submod shell-completion/list-collects main))')}"
  )
  local -a ignored
  ignored=('*.dep' '*.zo' 'compiled' '*/compiled')
  case "$1" in
  ( "dir" ) _wanted collections expl collection _files -W dirs -F ignored -/ \
            && return 0 ;;
  ( "file" ) _wanted libraries expl library-file _files \
               -W dirs -F ignored -g '*(+_racket_file_expander)' \
             && return 0 ;;
  esac
  return 1
}
_racket_read_libfile() { _racket_read_libfile_or_collect file; }
_racket_read_collect() { _racket_read_libfile_or_collect dir; }
_racket_read_path()    { _files; }

_racket_do_state() {
  if [[ -n $state ]] && (( $+functions[_racket_read_$state] )); then
    _racket_read_$state
  else
    return 1
  fi
}

RACKET_CHECKSUMS=()
_racket_self_test() {
  if (( $# )) { RACKET_CHECKSUMS+="$*"; } else
    echo "Testing..."
    local t command expected filter checksum
    for t in $RACKET_CHECKSUMS; do
      cmd=${t%%:*}
      expected=${t#*:}
      if [[ $expected = *:* ]]; then
        filter=${expected#*:}
        expected=${expected%%:*}
      else
        filter=cat
      fi
      # leave only alphanumerics, so it's insensitive to space & punctuations
      checksum=$(${(Q)"${(z)cmd}"} --help |& ${(Q)"${(z)filter}"} \
                   |& tr -cd '[:alnum:]' | cksum)
      checksum=${${(z)checksum}[1]}
      printf '  %s: ' "$cmd"
      if [[ "$checksum" = "$expected" ]]; then printf 'ok\n'
      else printf '*** error, expected: %s, got %s\n' "$expected" "$checksum"
      fi
    done
    echo "Done."
  fi
}

###############################################################################

_racket_self_test 'racket:2561387185:grep -v "Welcome to Racket"'

RACKET_COMMON=( -C -s -w -S : '(- : *)'{-h,--help}'[Display help]' )
RACKET_ARGS=( "$RACKET_COMMON[@]" )

# File and expression options:
RACKET_ARGS+=(
  '*'{-e,--eval}'[Evaluate expression]:expression: '
  '*'{-f,--load}'[Like -e `(load "FILE")'\'' without printing, or evaluates all from input when <file> is "-"]:file:_files'
  '*'{-t,--require}'[Like -e `(require (file "FILE"))'\'' and requires a main submodule if any]:file:_files'
  '*'{-l,--lib}'[Like -e `(require (lib "PATH"))'\'' and requires a main submodule if any]:library-file:->libfile'
  '*'-p'+[Like -e `(require (planet "PACKAGE"))'\'' and requires a main submodule if any]:planet-package: '
  '*'{-r,--script}'[Load a script (same as -f FILE -n FILE --)]:file:_files'
  '*'{-u,--require-script}'[Require a script (same as -tN- FILE)]:file:_files'
  # No need to do `-k' -- it's for internal use by launchers
  '(-m --main)'{-m,--main}'[Call `main'"'"' with command-line arguments]'
)

# Interaction options:
RACKET_ARGS+=(
  '(-i --repl)'{-i,--repl}'[Run interactive read-eval-print loop]'
  '(-n --no-lib)'{-n,--no-lib}'[Skip requiring init-lib for -i/-e/-f/-r]'
  '(-v --version)'{-v,--version}'[Show version]'
  '(-V --no-yield)'{-V,--no-yield}'[Skip yield handler on exit]'
)

# Configuration options:
RACKET_ARGS+=(
  '(-y --make)'{-y,--make}'[Yes, enable automatic update of compiled files]'
  '(-c --no-compiled)'{-c,--no-compiled}'[Disable loading of compiled files]'
  '(-q --no-init-file)'{-q,--no-init-file}'[Skip loading ~/.racketrc for -i]'
  '(-I)'-I'[Set init-lib]:library-file:->libfile'
  '(-X --collects)'{-X,--collects}'[Main collects dir ("" disables all)]:directory:_files -/'
  '*'{-S,--search}'[More collects dir (after main)]:directory:_files -/'
  '(-G --config)'{-G,--config}'[Main configuration directory]:directory:_files -/'
  '(-A --addon)'{-A,--addon}'[Addon directory]:directory:_files -/'
  '(-U --no-user-path)'{-U,--no-user-path}'[Ignore user-specific collects, etc.]'
  '(-R --compiled)'{-A,--addon}'[Set compiled-file search roots to directory]:directory:_files -/'
  '(-C --links)'{-C,--links}'[User-specific collection links file]:file:_files'
  '(-N --name)'{-N,--name}'[Sets (find-system-path '"'"'run-file)]:file:_files'
  '(-E --exec)'{-E,--exec}'[Sets (find-system-path '"'"'exec-file)]:file:_files'
  '(-j --no-jit)'{-j,--no-jit}'[Disable the just-in-time compiler]'
  '(-M --compile-any)'{-M,--compile-any}'[Compile to machine-independent form]'
  '(-d --no-delay)'{-d,--no-delay}'[Disable on-demand loading of syntax and code]'
  '(-b --binary)'{-b,--binary}'[Read stdin and write stdout/stderr in binary mode]'
  '(-W --warn)'{-W,--warn}'[Set stderr logging level]:log-level:(none fatal error warning info debug)'
  '(-O --stdout)'{-O,--stdout}'[Set stdout logging level]:log-level:(none fatal error warning info debug)'
  '(-L --syslog)'{-L,--syslog}'[Set syslog logging level]:log-level:(none fatal error warning info debug)'
  '(--compile-machine)'--compile-machine'[Compile for machine]:machine: '
  '(--cross-compiler)'--cross-compiler'[Use compiler plugin for machine]:machine: :plugin-dir: '
  '(--cross-server)'--cross-server'[Drive cross-compiler (as only option)]:machine: :compiler: :lib: '
)

# Main arguments:
RACKET_ARGS+=(
  '(-)1:racket-file:_files'
  '*::script-argument: _normal'
)

_racket_main() {
  _arguments "${RACKET_ARGS[@]}" && return 0
  _racket_do_state
}

###############################################################################

_racket_self_test 'raco:3382393175'
_raco() {
  if (( CURRENT > 2 )); then
    local subcmd="${words[2]}"
    curcontext="${curcontext%:*:*}:raco-$subcmd"
    (( CURRENT-- ))
    shift words
    if [[ $subcmd = -(h|-help) ]]; then _message 'no more arguments'
    elif (( $+functions[_raco_cmd_$subcmd] )); then _raco_cmd_$subcmd
    else _normal
    fi
  else
    local hline
    local -a cmdlist
    cmdlist=(
      {-h,--help}:'Display help'
      "${(f)$(_racket_call raco-command '
               (require raco/all-tools)
               (hash-for-each (all-tools)
                              (lambda (k v) (printf "~a:~a\n" k (caddr v))))')}"
    )
    _describe -t raco-commands 'raco command' cmdlist
  fi
}

_racket_self_test 'raco docs:3335848757'
_raco_cmd_docs() {
  _arguments "$RACKET_COMMON[@]" \
    '*:search-term: ' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco setup:201959535:tail -n +2' # full path for this one
_raco_cmd_setup() {
  local collections=(
    '(--only)'--only'[Set up only specified, even if none]'
    '(-l)'-l'[Setup specific collections]:*:collection:->collect'
    '(--pkgs)'--pkgs'[Setup collections in specified packages]:*:packages:->installed_package'
    '*'-P'[Setup specified PLaneT packages only]:owner: :package-name: :major-version: :minor-version: '
    '(--doc-index)'--doc-index'[Rebuild documentation index along with specified]'
    '(--tidy)'--tidy'[Clear references to removed items outside of specified]'
  )
  local tasks=(
    '(-c --clean)'{-c,--clean}'[Delete existing compiled files; implies -nxiIFDK]'
    '(--fast-clean)'--fast-clean'[Like --clean, but non-bootstrapping (can fail)]'
    '(-n --no-zo)'{-n,--no-zo}'[Do not create .zo files]'
    '(--trust-zos)'--trust-zos'[Trust existing .zos (use only with prepackaged .zos)]'
    '(--recompile-only)'--recompile-only'[Fail if compilation must start from source]'
    '(--sync-docs-only)'--sync-docs-only'[Sync/move documentation, but do not run or render]'
    '(-x --no-launcher)'{-x,--no-launcher}'[Do not produce launcher programs]'
    '(-F --no-foreign-libs)'{-F,--no-foreign-libs}'[Do not install foreign libraries]'
    '(--only-foreign-libs)'--only-foreign-libs'[Disable actions except installing foreign libraries]'
    '(-i --no-install)'{-i,--no-install}'[Do not call collection-specific pre-installers]'
    '(-I --no-post-install)'{-I,--no-post-install}'[Do not call collection-specific post-installers]'
    '(-d --no-info-domain)'{-d,--no-info-domain}'[Do not produce info-domain caches]'
    '(-D --no-docs)'{-D,--no-docs}'[Do not compile .scrbl files and do not build documentation]'
    '(--doc-pdf)'--doc-pdf'[Build documentation PDFs to directory]:dir:_files -/'
    '(-K --no-pkg-deps)'{-K,--no-pkg-deps}'[Do not check package dependencies]'
    '(--check-pkg-deps)'--check-pkg-deps'[Check package dependencies when collections specified]'
    '(--fix-pkg-deps)'--fix-pkg-deps'[Auto-repair package-dependency declarations]'
    '(--unused-pkg-deps)'--unused-pkg-deps'[Check for unused package-dependency declarations]'
    '(--chain)'--chain'[Select a continuation other than `setup/setup-go`]'
    '(--boot)'--boot'[Like `--chain`, but use compiled only from <dir>]'
  )
  local users=(
    '(-U,--no-user)'{-U,--no-user}'[Do not setup user-specific collections (implies --no-planet)]'
    '(--no-planet)'--no-planet'[Do not setup PLaneT packages]'
    '(--avoid-main)'--avoid-main'[Do not make main-installation files]'
    '(--force-user-docs)'--force-user-docs'[User-specific documentation even if matching installation]'
  )
  local modes=(
    '(-j --jobs --workers)'{-j,--jobs,--workers}'[Use N parallel jobs]:cores: '
    '(--places --processes)'--places'[Use places for parallel jobs]'
    '(--places --processes)'--processes'[Use processes for parallel jobs]'
    '(-v --verbose)'-v,--verbose'[See names of compiled files and info printfs]'
    '(-m --make-verbose)'{-m,--make-verbose}'[See make and compiler usual messages]'
    '(-r --compile-verbose)'{-r,--compile-verbose}'[See make and compiler verbose messages]'
    '(--mode)'--mode'[Select a compilation mode, such as "errortrace"]:mode:(errortrace)'
    '(--fail-fast)'--fail-fast'[Trigger a break on the first error]'
    '(--error-out)'--error-out'[On continuable error, create file and exit as success]:out:_files'
    '(--error-in)'--error-in'[Check file for report of previous errors]:in:_files'
    '(-p --pause)'{-p,--pause}'[Pause at the end if there are any errors]'
  )
  local archives=(
    '(--force)'--force'[Treat version mismatches for archives as mere warnings]'
    '(-a --all-users)'{-a,--all-users}'[Install archives to main (not user-specific) installation]'
    '(-A)'-A'[Unpack and install .plt archives]:plt archive:_files -g \*.plt'
  )
  _arguments "$RACKET_COMMON[@]" \
    "$collections[@]" \
    "$tasks[@]" \
    "$users[@]" \
    "$modes[@]" \
    "$archives[@]" \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco scribble:313127162'
_raco_cmd_scribble() {
  local exclusive_modes='(--html --htmls --html-tree --latex --pdf --xelatex --lualatex --dvipdf --latex-section --text --markdown)'
  _arguments "$RACKET_COMMON[@]" \
    "$exclusive_modes"--html'[Generate HTML-format output file (default)]' \
    "$exclusive_modes"--htmls'[Generate HTML-format output directory]' \
    "$exclusive_modes"--html-tree'[Generate HTML-format output directories N deep]:section-depth: ' \
    "$exclusive_modes"--latex'[Generate LaTeX-format output]' \
    "$exclusive_modes"--pdf'[Generate PDF-format output (via PDFLaTeX)]' \
    "$exclusive_modes"--xelatex'[Generate PDF-format output (via XeLaTeX)]' \
    "$exclusive_modes"--lualatex'[Generate PDF-format output (via LuaLaTeX)]' \
    "$exclusive_modes"--dvipdf'[Generate PDF-format output (via LaTeX, dvips, and pstopdf)]' \
    "$exclusive_modes"--latex-section'[Generate LaTeX-format output for section depth N]:section-depth: ' \
    "$exclusive_modes"--text'[Generate text-format output]' \
    "$exclusive_mods"--markdown'[Generate markdown-format output]' \
    '(--lib -l)'{--lib,-l}'[Treat argument as library paths instead of filesystem paths]:*:lib-file:->libfile' \
    '(--dest)'--dest'[Write output in directory]:directory:_files -/' \
    '(--dest-name)'--dest-name'[Write output as name]:name: ' \
    '(--dest-base)'--dest-base'[Start support-file names with prefix]:prefix: ' \
    '(--keep-at-dest-base)'--keep-at-dest-base'[Keep existing files at location of support files]' \
    '*'++convert'[Prefer image conversion to format]:format:(ps pdf svg png gif)' \
    '*'++style'[Add given .css/.tex file after others]:style-file:_files -g \*.\(css\|tex\)' \
    '(--style)'--style'[Use given base .css/.tex file]:style-file:_files -g \*.\(css\|tex\)' \
    '(--prefix)'--prefix'[Use given .html/.tex prefix (for doctype/documentclass)]:prefix-file:_files -g \*.\(html\|htm\|tex\)' \
    '(--link-section)'--link-section'[Support section links for markdown]' \
    '*'++extra'[Add given file]:file:_files' \
    '*'--redirect-main'[Redirect main doc links to url]:url: ' \
    '*'--redirect'[Redirect external links to tag search via url]:url: ' \
    '(+m ++main-xref-in)'{+m,++main-xref-in}'[load format-speficic cross-ref info for all installed library collections]' \
    '*'++xref-in'[Load format-specific cross-ref info by]:module-path:->libfile:proc-id: ' \
    '*'--info-out'[Write format-specific cross-ref info to file]:file:_files' \
    '*'++info-in'[Load format-specific cross-ref info from file]:file:_files' \
    '*'++arg'[Add argument to current-command-line-arguments]:argument: ' \
    '(--quiet)'--quiet'[Suppress output-file and undefined-tag reporting]' \
    '(--doc-binding)'--doc-binding'[Render document provided as ID instead of `doc'\'']:doc-binding: ' \
    '(--make -y)'{--make,-y}'[Enable automatic update of compiled files]' \
    '(--errortrace)'--errortrace'[Enable errortrace]' \
    '*:scribble-file:_files -g \*.scrbl' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco exe:1343818001'
_raco_cmd_exe() {
  _arguments "$RACKET_COMMON[@]" \
    '(-o)'-o'[Write executable as file]:output-executable:_files' \
    '(--gui)'--gui'[Generate GUI executable]' \
    '(-l --launcher)'{-l,--launcher}'[Generate a launcher]' \
    '(--embed-dlls)'--embed-dlls'[On Windows, embed DLLs in the executable]' \
    '(--config-path)'--config-path'[Set path as configuration directory for executable]:config:_files -/' \
    '(--collects-path)'--collects-path'[Set path as main collects for executable]:collection:->collect' \
    '(--collects-dest)'--collects-dest'[Write collection code to directory]:directory:_files -/' \
    '(--ico)'--ico'[Set Windows icon for executable]:ico-file:_files -g \*.ico' \
    '(--icns)'--icns'[Set Mac OS X icon for executable]:icns-file:_files -g \*.icns' \
    '(--orig-exe)'--orig-exe'[Use original executable instead of stub]' \
    '(--3m --cgc --cs)'--3m'[Generate using 3m variant]' \
    '(--3m --cgc --cs)'--cgc'[Generate using CGC variant]' \
    '(--3m --cgc --cs)'--cs'[Generate using CS variant]' \
    '*'++lib'[Embed lib in executable]:lib-file:_files' \
    '*'++lang'[Embed support for `#lang <lang>'\'' in executable]:lang:->libfile' \
    '*'++named-lib'[Embed lib with name using prefix]:prefix: :lib-file:_files' \
    '*'++named-file'[Embed file with name using prefix]:prefix: :file:_files' \
    '*'++aux'[Extra executable info (based on aux-file suffix)]:aux-file:_files' \
    '*'++exf'[Add flag to embed in executable]:flag: ' \
    '*'--exf'[Remove flag to embed in executable]:flag: ' \
    '*'--exf-clear'[Clear flags to embed in executable]' \
    '*'--exf-show'[Show flags to embed in executable]' \
    '(-v)'-v'[Verbose mode]' \
    '(--vv)'--vv'[Very verbose mode]' \
    '*:source-file:_files -g \*.\(rkt\|ss\|scm\)' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco make:3873989386'
_raco_cmd_make() {
  _arguments "$RACKET_COMMON[@]" \
    '*'-l'[Compile path as a collection-based module path]:path:->libfile' \
    '(-j)'-j'[Use N parallel jobs]:cores: ' \
    '(--disable-inline)'--disable-inline'[Disable procedure inlining during compilation]' \
    '(--disable-constant)'--disable-constant'[Disable enforcement of module constants]' \
    '(--no-deps)'--no-deps'[Compile immediate files without updating dependencies]' \
    '(-p --prefix)'{-p,--prefix}'[Add elaboration-time prefix file for --no-deps]:prefix-file:_files' \
    '(--no-prim)'--no-prim'[Do not assume `scheme'"'"' bindings at top level for --no-deps]' \
    '(-v)'-v'[Verbose mode]' \
    '(--vv)'--vv'[Very verbose mode]' \
    '*:source-files:_files' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco ctool:1038338951'
_raco_cmd_ctool() {
  _arguments "$RACKET_COMMON[@]" \
    '(--cc --ld -x --xform --c-mods)'--xx'[Compile arbitrary file(s) for an extension: .c -> .o]' \
    '(--cc --ld -x --xform --c-mods)'--ld'+[Link arbitrary file(s) to create extension: .o -> .so]:extension-file:_files' \
    '(--cc --ld -x --xform --c-mods)'{-x,--xform}'[Convert for 3m compilation: .c -> .c]' \
    '(--cc --ld -x --xform --c-mods)'--c-mods'+[Write C-embeddable module bytecode to file]:file:_files' \
    '(--3m --cgc)'--3m'[Compile/link for 3m (default)]' \
    '(--3m --cgc)'--cgc'[Compile/link for CGC]' \
    '(-n --name)'{-n,--name}'+[Use name as extra part of public low-level names]:name: ' \
    '(-d --destination)'{-d,--destination}'+[Output --cc/--ld/-x file(s) to directory]:destination-directory:_files -/' \
    '(--tool)'--tool'+[Use pre-defined tool as C compiler/linker]:tool:(gcc cc)' \
    '(--compiler)'--compiler'+[Use specified C compiler]:compiler-path:_files' \
    '*'++ccf'+[Add C compiler flag]:flag: ' \
    '*'--ccf'+[Remove C compiler flag]:flag: ' \
    '*'--ccf-clear'[Clear C compiler flags]' \
    '*'--ccf-show'[Show C compiler flags]' \
    '(--linker)'--linker'+[Use specified C linker]:linker-path:_files' \
    '*'++ldf'+[Add C linker flag]:flag: ' \
    '*'--ldf'+[Remove C linker flag]:flag: ' \
    '*'--ldf-clear'[Clear C linker flags]' \
    '*'--ldf-show'[Show C linker flags]' \
    '*'++ldl'+[Add C linker library]:library-file:_files' \
    '*'--ldl-show'[Show C linker libraries]' \
    '*'++cppf'+[Add C preprocess (xform) flag]:flag: ' \
    '*'--cppf'+[Remove C preprocess (xform) flag]:flag: ' \
    '*'--cppf-clear'[Clear C preprocess (xform) flags]' \
    '*'--cppf-show'[Show C preprocess (xform) flags]' \
    '*'++lib'+[Embed lib in --c-mods output]:lib-file:_files' \
    '(-v)'-v'[Slightly verbose mode, including version banner and output files]' \
    '(--vv)'--vv'[Very verbose mode]' \
    '*:file:_files' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco distribute:1595797597'
_raco_cmd_distribute() {
  _arguments "$RACKET_COMMON[@]" \
    '(--collects-path)'--collects-path'[Set path as main collects for executables]:collection:->collect' \
    '*'++collects-copy'[Add collects in dir to directory]:collection:->collect' \
    '(-v)'-v'[Verbose mode]' \
    '1:destination-directory:_files -/' \
    '*:executable:_files' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco link:1334896662'
_raco_cmd_link() {
  _arguments "$RACKET_COMMON[@]" \
    '(-l --list)'{-l,--list}'[Show the link table (after changes)]' \
    '(-n --name -d --root)'{-n,--name}'+[Collection name to add (single dir) or remove]:name: ' \
    '(-n --name -d --root)'{-d,--root}'[Treat dir as a collection root]' \
    '(-x --version-regexp)'{-x,--version-regexp}'+[Set the version pregexp]:regexp: ' \
    '(-r --remove)'{-r,--remove}'[Remove links for the specified directories]' \
    '(-u --user -i --installation -f --file)'{-u,--user}'[Adjust/list user-specific links]' \
    '(-u --user -i --installation -f --file)'{-i,--installation}'[Adjust/list installation-wide links]' \
    '(-u --user -i --installation -f --file)'{-f,--file}'+[Select an alternate link file]:file:_files -g \*.rktd' \
    '(--repair)'--repair'[Enable repair mode to fix existing links]' \
    '*:directory:_files -/' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco pack:1977512558'
_raco_cmd_pack() {
  _arguments "$RACKET_COMMON[@]" \
    '(--collect)'--collect'[paths specify collections instead of files/dirs]' \
    '(--plt-name)'--plt-name'+[Set the printed name describing the archive]:archive-name: ' \
    '(--replace)'--replace'[Files in archive replace existing files when unpacked]' \
    '(--at-plt)'--at-plt'[Files/dirs in archive are relative to user'"'"'s add-ons directory]' \
    '(--all-users --force-all-users)'--all-users'[Files/dirs in archive go to PLT installation if writable]' \
    '(--all-users --force-all-users)'--force-all-users'[Files/dirs forced to PLT installation]' \
    '(--include-compiled)'--include-compiled'[Include "compiled" subdirectories in the archive]' \
    '*'++setup'+[Setup given collect after the archive is unpacked]:collection:->collect' \
    '(-v)'-v'[Verbose mode]' \
    '1:destination-archive:_files -g \*.plt' \
    '*:file-or-directory:->rest' \
  && return 0
  echo "$state" > /tmp/zzz
  if [[ "$state" = "rest" ]]; then
    if (( $+opt_args[--collect] )); then state="collect"; else state="path"; fi
  fi
  _racket_do_state
}

_racket_self_test 'raco unpack:2639538734'
_raco_cmd_unpack() {
  _arguments "$RACKET_COMMON[@]" \
    '(-l --list)'{-l,--list}'[List archive content]' \
    '(-c --config)'{-c,--config}'[Show archive configuration]' \
    '(-f --force)'{-f,--force}'[Replace existing files when unpacking]' \
    '*:plt-archive:_files -g \*.plt' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco expand:1013149279'
_raco_cmd_expand() {
  _arguments "$RACKET_COMMON[@]" \
    '(--columns -n)'{--columns,-n}'[Format for N columns]:columns: ' \
    '*:source-file:_files' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco decompile:1342114717'
_raco_cmd_decompile() {
  _arguments "$RACKET_COMMON[@]" \
    '*:source-or-bytecode-file:_files' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco demodularize:33137783'
_raco_cmd_demodularize() {
  _arguments "$RACKET_COMMON[@]" \
    '*'{-e,--exclude-modules}'+[Exclude module from flattening]:module-path:->libfile' \
    '(-o)'-o'+[Write output as dest-filename]:dest-filename:_files' \
    '*:file:_files' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco test:2023323379'
_raco_cmd_test() {
  local modes='(--collection -c --package -p --lib -l --modules -m)'
  _arguments "$RACKET_COMMON[@]" \
    "$modes"{-c,--collection}'[Interpret arguments as collections]' \
    "$modes"{-l,--lib}'[Interpret arguments as libraries]' \
    "$modes"{-p,--package}'[Interpret arguments as packages]' \
    "$modes"{-m,--modules}'[Interpret arguments as modules (ignore argument unless ".rkt", ".scrbl", or enabled by "info.rkt")]' \
    '(--drdr)'--drdr'[Configure defaults to imitate DrDr]' \
    '*'{-s,--submodule}'[Runs submodule name (defaults to `test'"'"')]:submodule: ' \
    '*'++arg'[Add argument to current-command-line-arguments]:argument: ' \
    '*'++args'[Adds each whitespace-delimited in args like ++arg]:arguments: ' \
    '(-r --run-if-absent -x --no-run-if-absent)'{-r,--run-if-absent}'[Require module if submodule is absent (on by default)]' \
    '(-r --run-if-absent -x --no-run-if-absent)'{-x,--no-run-if-absent}'[Require nothing if submodule is absent]' \
    '(--first-avail)'--first-avail'[Run only the first available submodule]' \
    '(--configure-runtime)'--configure-runtime'[Run the `configure-runtime'\'' submodule]' \
    '(--direct --process --place)'--direct'[Run tests directly (default for a single file)]' \
    '(--direct --process --place)'--process'[Run tests in separate processes (default for multiple files)]' \
    '(--direct --process --place)'--place'[Run tests in places]' \
    '(-j --jobs)'{-j,--jobs}'[Run up to N tests in parallel]:number of tests: ' \
    '(--timeout)'--timeout'[Set default timeout in seconds]:timeout seconds: ' \
    '(--fresh-user)'--fresh-user'[Fresh PLTUSERHOME, etc., for each test]' \
    '(--empty-stdin)'--empty-stdin'[Call program with an empty stdin]' \
    '(--quiet-program -Q)'{--quiet-program,-Q}'[Quiet the program]' \
    '(--check-stderr -e)'{--check-stderr,-e}'[Treat stderr output as a test failure]' \
    '(--deps)'--deps'[If treating arguments as packages, also test dependencies]' \
    '(--errortrace --make -y)'--errortrace'[Load errortrace before testing]' \
    '(--errortrace --make -y)'{--make,-y}'[Enable automatic update of compiled files]' \
    '*'++ignore-stderr'[Enable stderr output that matches #px"pattern"]:pattern: ' \
    '(-q --quiet)'{-q,--quiet}'+[Suppress `raco test: ...` message]' \
    '(--heartbeat)'--heartbeat'[Periodically report that a test is still running]' \
    '(--table, -t)'--table, -t'[Print a summary table]' \
    '(--output -o)'{--output,-o}'[Save stdout and stderr to file, overwrite if it exists.]:output:_files' \
    '*:source-file-or-directory:_files' \
  && return 0
  _racket_do_state
}

_racket_self_test 'raco pkg:3232773977'
_raco_cmd_pkg() {
  if (( CURRENT > 2 )); then
    local subcmd="${words[2]}"
    curcontext="${curcontext%:*:*}:raco-pkg-$subcmd"
    (( CURRENT-- ))
    shift words
    if [[ $subcmd = -(h|-help) ]]; then _message 'no more arguments'
    elif (( $+functions[_raco_cmd_pkg_$subcmd] )); then _raco_cmd_pkg_$subcmd
    else _normal
    fi
  else
    local hline
    local -a cmdlist
    local pfx='^  raco pkg '
    cmdlist=(
      {-h,--help}:'Display help'
      ${(f)"$(raco pkg | grep "$pfx" | sed -e "s/$pfx"'\([^ ]*\) *\(.*\)/\1:\2/')"}
    )
    _describe -t raco-pkg-commands 'raco pkg command' cmdlist
  fi
}

COMMON_PKG_ARGS=(
  '*'--catalog'[Use instead of configured catalogs]:catalog: '
  '(--all-platforms)'--all-platforms'[Follow package dependencies for all platforms]'
  '(--force)'--force'[Ignore conflicts]'
  '(--ignore-checksums)'--ignore-checksums'[Ignore checksums]'
  '(--strict-doc-conflicts)'--strict-doc-conflicts'[Report doc-name conflicts, even for user scope]'
  '(--no-cache)'--no-cache'[Disable download cache]'
  '(--dry-run)'--dry-run'[Don'\''t actually change package installation]'
  '(--no-setup)'--no-setup'[Don'\''t `raco setup` after changing packages (usually a bad idea)]'
  '(-D --no-docs)'{-D,--no-docs}'[Do not compile .scrbl files and do not build documentation]'
  '(--recompile-only)'--recompile-only'[Expect built packages, possibly machine-independent]'
  '(-j --jobs)'{-j,--jobs}'[Setup with N parallel jobs]:cores: '
  '(--batch)'--batch'[Disable interactive mode and all prompts]'
  '(--deps --auto)'--deps'[Specify the behavior for uninstalled dependencies]:mode:(fail force search-ask search-auto)'
  '(--deps --auto)'--auto'[Shorthand for `--deps search-auto'\'']'
)

INSTALL_UPDATE_ARGS=(
  '(-t --type)'{-t,--type}'[Specify type of source, instead of inferred]:type:(file dir file-url dir-url git git-url github name)'
  '(-n --name)'{-n,--name}'[Specify name of package, instead of inferred; makes sense only when a single pkg-source is given]:name: '
  '(--checksum)'--checksum'[Checksum of package, either expected or selected; makes sense only when a single pkg-source is given]:checksum: '
  '(--update-deps)'--update-deps'[For `search-ask'\'' or `search-auto'\'', also update dependencies]'
  '(--ignore-implies)'--ignore-implies'[When updating, treat `implies'\'' like other dependencies]'
  '(--multi-clone)'--multi-clone'[Specify treatment of multiple clones of a repository]:mode:(convert ask fail force)'
  '(--pull)'--pull'[Specify `git pull'\'' mode for repository clones]:mode:(ff-only try rebase)'
  '(--no-trash)'--no-trash'[Delete uninstalled/updated, instead of moving to a trash folder]'
)

SCOPE_ARGS=(
  '(--scope -i --installation -u --user --scope-dir)'--scope'[Select package scope]:scope:(installation user)'
  '(--scope -i --installation -u --user --scope-dir)'{-i,--installation}'[Shorthand for `--scope installation'\'']'
  '(--scope -i --installation -u --user --scope-dir)'{-u,--user}'[Shorthand for `--scope user'\'']'
  '(--scope -i --installation -u --user --scope-dir)'--scope-dir'[Select package scope <dir>]:scope:_files -/'
)

_racket_self_test 'raco pkg install:2252657386'
_raco_cmd_pkg_install() {
  local specs=(
    '(--link --static-link --copy --clone --source --binary --binary-lib)'--link'[Link a directory package source in place (default for a directory)]'
    '(--link --static-link --copy --clone --source --binary --binary-lib)'--static-link'[Link in place, promising collections do not change]'
    '(--link --static-link --copy --clone --source --binary --binary-lib)'--copy'[Treat directory sources the same as other sources]'
    '(--link --static-link --copy --clone --source --binary --binary-lib)'--clone'[Clone Git and GitHub package sources and link]:clone directory: '
    '(--link --static-link --copy --clone --source --binary --binary-lib)'--source'[Strip packages'\'' built elements before installing; implies --copy]'
    '(--link --static-link --copy --clone --source --binary --binary-lib)'--binary'[Strip packages'\'' source elements before installing; implies --copy]'
    '(--link --static-link --copy --clone --source --binary --binary-lib)'--binary-lib'[Strip source & documentation before installing; implies --copy]'
    '(--skip-installed)'--skip-installed'[Skip a pkg-source if already installed]'
    '(--pkgs)'--pkgs'[Install only the specified packages, even when none are provided]'
    '(--fail-fast)'--fail-fast'[Break `raco setup'\'' when it discovers an error]'
    '*:package source: '
  )
  _arguments "$RACKET_COMMON[@]" "$COMMON_PKG_ARGS[@]" "$INSTALL_UPDATE_ARGS[@]" "$SCOPE_ARGS[@]" "$specs[@]" && return 0
  _racket_do_state
}

_racket_self_test 'raco pkg update:1525052410'
_raco_cmd_pkg_update() {
  local specs=(
    '(-a --all)'{-a,--all}'[Update all packages if no pkg-source is given]'
    '(--lookup)'--lookup'[When pkg-source is a name, get source from a catalog instead of using the currently installed source; unclones or combines with `--clone'\'']'
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--link'[Link a directory package source in place (default for a directory)]'
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--static-link'[Link in place, promising collections do not change]'
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--copy'[Treat directory sources the same as other sources]'
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--clone'[Clone Git and GitHub package sources and link]:clone directory: '
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--unclone'[Unclones when currently a clone; alias for --lookup]'
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--source'[Strip packages'\'' built elements before installing; implies --copy]'
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--binary'[Strip packages'\'' source elements before installing; implies --copy]'
    '(--link --static-link --copy --clone --unclone --source --binary --binary-lib)'--binary-lib'[Strip source & documentation before installing; implies --copy]'
    '(--skip-uninstalled)'--skip-uninstalled'[Skip a pkg-source if not installed]'
    '*:package source:->installed_package'
  )
  _arguments "$RACKET_COMMON[@]" "$COMMON_PKG_ARGS[@]" "$INSTALL_UPDATE_ARGS[@]" "$SCOPE_ARGS[@]" "$specs[@]" && return 0
  _racket_do_state
}

_racket_self_test 'raco pkg uninstall:1205341767'
_raco_cmd_pkg_uninstall() {
  local specs=(
    '(--demote)'--demote'[Demote to auto-installed, instead of removing]'
    '(--force)'--force'[Uninstall even if package has dependents]'
    '(--auto)'--auto'[Also uninstall auto-installed packages that have no dependents]'
    '(--dry-run)'--dry-run'[Don'\''t actually change package installation]'
    '(--no-setup)'--no-setup'[Don'\''t `raco setup` after changing packages (usually a bad idea)]'
    '(-D --no-docs)'{-D,--no-docs}'[Do not compile .scrbl files and do not build documentation]'
    '(--recompile-only)'--recompile-only'[Expect built packages, possibly machine-independent]'
    '(-j --jobs)'{-j,--jobs}'[Setup with N parallel jobs]:cores: '
    '(--batch)'--batch'[Disable interactive mode and all prompts]'
    '(--no-trash)'--no-trash'[Delete uninstalled/updated, instead of moving to a trash folder]'
    '*:package source:->installed_package'
  )
  _arguments "$RACKET_COMMON[@]" "$SCOPE_ARGS[@]" "$specs[@]" && return 0
  _racket_do_state
}

_racket_self_test 'raco pkg new:2017728815'
_raco_cmd_pkg_new() {
  _arguments "$RACKET_COMMON[@]" '1:package: ' && return 0
  _racket_do_state
}

_racket_self_test 'raco pkg show:2737181330'
_raco_cmd_pkg_show() {
  local specs=(
    '(-a --all)'{-a,--all}'[Show auto-installed packages, too]'
    '(-l --long)'{-l,--long}'[Show full column content]'
    '(--full-checksum)'--full-checksum'[Show the full checksum]'
    '(--rx)'--rx'[Treat packages as regular expressions]'
    '(-d --dir)'{-d,--dir}'[Show the directory where the package is installed]'
    # like SCOPE_ARGS, but with -v/--version
    '(--scope -i --installation -u --user --scope-dir -v --version)'--scope'[Select package scope]:scope:(installation user)'
    '(--scope -i --installation -u --user --scope-dir -v --version)'{-i,--installation}'[Shorthand for `--scope installation'\'']'
    '(--scope -i --installation -u --user --scope-dir -v --version)'{-u,--user}'[Shorthand for `--scope user'\'']'
    '(--scope -i --installation -u --user --scope-dir -v --version)'--scope-dir'[Select package scope <dir>]:scope:_files -/'
    '(--scope -i --installation -u --user --scope-dir -v --version)'{-v,--version}'[Show user-specific for installation version]:version: '
    '*:package:->installed_package'
  )
  _arguments "$RACKET_COMMON[@]" "$specs[@]" && return 0
  _racket_do_state
}

_racket_self_test 'raco pkg migrate:2132316292'
_raco_cmd_pkg_migrate() {
  local specs=(
    '(--source --binary --binary-lib)'--source'[Strip built elements of the package before installing]'
    '(--binary --binary --binary-lib)'--binary'[Strip source elements of the package before installing]'
    '(--binary-lib --binary --binary-lib)'--binary-lib'[Strip source elements and documentation before installing]'
  )
  _arguments "$RACKET_COMMON[@]" "$COMMON_PKG_ARGS[@]" "$SCOPE_ARGS[@]" "$specs[@]" '1:from version:->migrate_version' && return 0
  _racket_do_state
}

_racket_self_test 'raco planet:1582997403'
_raco_cmd_planet() {
  if (( CURRENT > 2 )); then
    local subcmd="${words[2]}"
    curcontext="${curcontext%:*:*}:raco-planet-$subcmd"
    (( CURRENT-- ))
    shift words
    if [[ $subcmd = -(h|-help) ]]; then _message 'no more arguments'
    elif (( $+functions[_raco_cmd_planet_$subcmd] )); then _raco_cmd_planet_$subcmd
    else _normal
    fi
  else
    local hline
    local -a cmdlist
    local pfx='^  raco planet '
    cmdlist=(
      {-h,--help}:'Display help'
      ${(f)"$(raco planet | grep "$pfx" \
                          | sed -e "s/$pfx"'\([^ ]*\) *\(.*\)/\1:\2/')"}
    )
    _describe -t raco-planet-commands 'raco planet command' cmdlist
  fi
}

_racket_self_test 'raco planet clearlinks:145158300'
_raco_cmd_planet_clearlinks() {
  _arguments "$RACKET_COMMON[@]" \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet create:3318289542'
_raco_cmd_planet_create() {
  _arguments "$RACKET_COMMON[@]" \
    '(-f --force)'{-f,--force}'[force a package to be created even if its info.rkt file contains errors.]' \
    '1:destination-archive:_files -g \*.plt' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet fetch:4273560882'
_raco_cmd_planet_fetch() {
  _arguments "$RACKET_COMMON[@]" \
    '(-):owner: ' \
    ':package-name: ' \
    ':major-version: ' \
    ':minor-version: ' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet fileinject:3090983232'
_raco_cmd_planet_fileinject() {
  _arguments "$RACKET_COMMON[@]" \
    '(-):owner: ' \
    ':plt-archive:_files -g \*.plt' \
    ':major-version: ' \
    ':minor-version: ' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet install:1001510693'
_raco_cmd_planet_install() {
  _arguments "$RACKET_COMMON[@]" \
    '(-):owner: ' \
    ':package-name: ' \
    ':major-version: ' \
    ':minor-version: ' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet link:2118742145'
_raco_cmd_planet_link() {
  _arguments "$RACKET_COMMON[@]" \
    '(-):owner: ' \
    ':package-name: ' \
    ':major-version: ' \
    ':minor-version: ' \
    ':directory:_files -/' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet open:4239735370'
_raco_cmd_planet_open() {
  _arguments "$RACKET_COMMON[@]" \
    '(-):plt-archive:_files -g \*.plt' \
    ':target-directory:_files -/' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet print:2975791845'
_raco_cmd_planet_print() {
  _arguments "$RACKET_COMMON[@]" \
    '(-):plt-archive:_files -g \*.plt' \
    ':path-in-plt-aarchive: ' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet remove:3543578058'
_raco_cmd_planet_remove() {
  _arguments "$RACKET_COMMON[@]" \
    '(-e --erase)'{-e,--erase}'[also remove the package'"'"'s distribution file from the uninstalled-package cache]' \
    '(-):owner: ' \
    ':package-name: ' \
    ':major-version: ' \
    ':minor-version: ' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet show:3911537255'
_raco_cmd_planet_show() {
  _arguments "$RACKET_COMMON[@]" \
    '(-p --packages -l --linkage -a --all)'{-p,--packages}'[show packages only (default)]' \
    '(-p --packages -l --linkage -a --all)'{-l,--linkage}'[show linkage table only]' \
    '(-p --packages -l --linkage -a --all)'{-a,--all}'[show packages and linkage]' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet structure:561630587'
_raco_cmd_planet_structure() {
  _arguments "$RACKET_COMMON[@]" \
    ':plt-archive:_files -g \*.plt' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet unlink:1307144701'
_raco_cmd_planet_unlink() {
  _arguments "$RACKET_COMMON[@]" \
    '(-q --quiet)'{-q,--quiet}'[don'"'"'t signal an error on nonexistent links]' \
    '(-):owner: ' \
    ':package-name: ' \
    ':major-version: ' \
    ':minor-version: ' \
  && return 0
  _racket_do_state
}
_racket_self_test 'raco planet url:3825697949'
_raco_cmd_planet_url() {
  _arguments "$RACKET_COMMON[@]" \
    '(-):owner: ' \
    ':package-name: ' \
    ':major-version: ' \
    ':minor-version: ' \
  && return 0
  _racket_do_state
}

###############################################################################

_racket() {
  if [[ $1 = --self-test ]]; then _racket_self_test; return; fi
  local curcontext="$curcontext" context state line
  typeset -A opt_args
  case "$service" in
  ( "racket" ) _racket_main "$@" ;;
  ( "raco"   ) _raco "$@" ;;
  ( * ) return 1 ;;
  esac
}

if [[ -n $service ]]; then _racket "$@"
else # loaded directly => define the completion (load if needed)
  if (( ! $+functions[compdef] )); then autoload -U compinit; compinit; fi
  compdef _racket racket raco
fi
