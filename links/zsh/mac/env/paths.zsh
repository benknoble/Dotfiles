[[ -d /usr/local/lib/ruby/gems/3.3.0/bin ]] && pathadd_front /usr/local/lib/ruby/gems/3.3.0/bin
[[ -d /usr/local/opt/ruby/bin ]] && pathadd_front /usr/local/opt/ruby/bin

[[ -d /usr/local/smlnj/bin ]] && pathadd /usr/local/smlnj/bin

[[ -d /Applications/MacVim.app/ ]] && pathadd /Applications/MacVim.app/Contents/bin

[[ -d /usr/local/opt/openjdk/ ]] && {
  pathadd_front /usr/local/opt/openjdk/bin
  pathadd_front man /usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home/man
}
