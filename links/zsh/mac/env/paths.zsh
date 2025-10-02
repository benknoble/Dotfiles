[[ -d "$brew_prefix"/lib/ruby/gems/3.3.0/bin ]] && pathadd_front "$brew_prefix"/lib/ruby/gems/3.3.0/bin
[[ -d "$brew_prefix"/lib/ruby/gems/3.4.0/bin ]] && pathadd_front "$brew_prefix"/lib/ruby/gems/3.4.0/bin
[[ -d "$brew_prefix"/opt/ruby/bin ]] && pathadd_front "$brew_prefix"/opt/ruby/bin

[[ -d "$brew_prefix"/smlnj/bin ]] && pathadd "$brew_prefix"/smlnj/bin

[[ -d /Applications/MacVim.app/ ]] && pathadd /Applications/MacVim.app/Contents/bin

[[ -d "$brew_prefix"/opt/openjdk/ ]] && {
  pathadd_front "$brew_prefix"/opt/openjdk/bin
  pathadd_front man "$brew_prefix"/opt/openjdk/libexec/openjdk.jdk/Contents/Home/man
}
