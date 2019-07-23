SMLNJ="$(brew --prefix)"/smlnj/bin
if [[ -d "$SMLNJ" ]]; then
  pathadd "$SMLNJ"
fi
unset SMLNJ
