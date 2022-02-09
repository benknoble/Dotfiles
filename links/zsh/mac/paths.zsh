[[ -d /usr/local/lib/ruby/gems/2.7.0/bin ]] && pathadd_front /usr/local/lib/ruby/gems/2.7.0/bin
[[ -d /usr/local/opt/ruby/bin ]] && pathadd_front /usr/local/opt/ruby/bin

[[ -d /usr/local/smlnj/bin ]] && pathadd /usr/local/smlnj/bin

[[ -d /Applications/MacVim.app/ ]] && pathadd /Applications/MacVim.app/Contents/bin

[[ -d /Applications/MATLAB_R2019a.app/ ]] && {
  pathadd /Applications/MATLAB_R2019a.app/bin
  pathadd /Applications/MATLAB_R2019a.app/bin/maci64
}

[[ -d /usr/local/opt/openjdk/ ]] && {
  pathadd_front /usr/local/opt/openjdk/bin
  pathadd_front man /usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/man
}

command -v racket &>/dev/null && {
  racket_paths=($(IFS=$'\n' racket -I racket/base -e '
    (require setup/dirs)
    (for-each displayln
      (list (find-user-console-bin-dir)
            (find-user-gui-bin-dir)
            (find-user-apps-dir)
            (find-user-man-dir)))
  '))
  pathadd $racket_paths[1]
  pathadd $racket_paths[2]
  pathadd $racket_paths[3]
  pathadd man $racket_paths[4]
}
