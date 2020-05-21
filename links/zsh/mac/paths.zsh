pathadd_front /usr/local/lib/ruby/gems/2.7.0/bin
pathadd_front /usr/local/opt/ruby/bin

pathadd /usr/local/smlnj/bin

() {
  local texpath=/usr/local/texlive/2019
  pathadd_front man "$texpath"/texmf-dist/doc/man
  pathadd_front info "$texpath"/texmf-dist/doc/info
  pathadd_front "$texpath"/bin/x86_64-darwinlegacy
}

pathadd /Applications/MacVim.app/Contents/bin

pathadd /Applications/MATLAB_R2019a.app/bin
pathadd /Applications/MATLAB_R2019a.app/bin/maci64
