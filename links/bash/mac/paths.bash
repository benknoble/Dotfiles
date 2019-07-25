# gem path
pathadd_front /usr/local/lib/ruby/gems/2.6.0/bin

# ruby path
pathadd_front /usr/local/opt/ruby/bin

SMLNJ="$(brew --prefix)"/smlnj/bin
if [[ -d "$SMLNJ" ]]; then
  pathadd "$SMLNJ"
fi
unset SMLNJ
