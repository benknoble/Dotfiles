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

[[ -d '/Applications/Racket v8.0/' ]] && {
  pathadd man '/Applications/Racket v8.0/man'
}
