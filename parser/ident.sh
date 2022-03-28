# source this file: ident.sh
letter() {
  [[ "$1" =~ [a-z] ]]  
}
digit() {
  [[ "$1" =~ [0-9] ]]
}

letter_or_digit() {
  letter "$1" || digit "$1"
}
