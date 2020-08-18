# gem path
pathadd_front /usr/local/lib/ruby/gems/2.7.0/bin

# ruby path
pathadd_front /usr/local/opt/ruby/bin

SMLNJ=/usr/local/smlnj/bin
pathadd "$SMLNJ"
unset SMLNJ

pathadd /Applications/MacVim.app/Contents/bin

pathadd /Applications/MATLAB_R2019a.app/bin
pathadd /Applications/MATLAB_R2019a.app/bin/maci64
