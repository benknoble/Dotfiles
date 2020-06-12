[[ -d /usr/local/lib/ruby/gems/2.7.0/bin ]] && pathadd_front /usr/local/lib/ruby/gems/2.7.0/bin
[[ -d /usr/local/opt/ruby/bin ]] && pathadd_front /usr/local/opt/ruby/bin

[[ -d /usr/local/smlnj/bin ]] && pathadd /usr/local/smlnj/bin

() {
  local texpath=/usr/local/texlive/2019
  [[ -d "$texpath" ]] && {
    pathadd_front man "$texpath"/texmf-dist/doc/man
    pathadd_front info "$texpath"/texmf-dist/doc/info
    pathadd_front "$texpath"/bin/x86_64-darwinlegacy
  }
}

[[ -d /Applications/MacVim.app/ ]] && pathadd /Applications/MacVim.app/Contents/bin

[[ -d /Applications/MATLAB_R2019a.app/ ]] && {
  pathadd /Applications/MATLAB_R2019a.app/bin
  pathadd /Applications/MATLAB_R2019a.app/bin/maci64
}

[[ -d /usr/local/opt/openjdk/ ]] && {
  pathadd_front /usr/local/opt/openjdk/bin
  pathadd_front man /usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/man
}
