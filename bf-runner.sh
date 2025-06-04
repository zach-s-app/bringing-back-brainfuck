#!/bin/bash
# usage: bash bf-runner.sh file.bf

if [ -z "$1" ]; then
  echo "Usage: $0 file.bf"
  exit 1
fi

code=$(cat "$1" | tr -d -c '><+-.,[]')

cells=()
pos=0
codepos=0
length=${#code}
cells[0]=0

while [ $codepos -lt $length ]; do
  cmd=${code:$codepos:1}
  case "$cmd" in
    '>')
      pos=$((pos+1))
      if [ -z "${cells[$pos]}" ]; then cells[$pos]=0; fi
      ;;
    '<')
      pos=$((pos-1))
      if [ $pos -lt 0 ]; then pos=0; fi
      ;;
    '+')
      cells[$pos]=$(( (cells[$pos]+1) % 256 ))
      ;;
    '-')
      cells[$pos]=$(( (cells[$pos]-1+256) % 256 ))
      ;;
    '.')
      printf "\\$(printf '%03o' ${cells[$pos]})"
      ;;
    ',')
      read -n1 -s input
      if [ -z "$input" ]; then
        cells[$pos]=0
      else
        # get ASCII code of input
        ascii=$(printf '%d' "'$input")
        cells[$pos]=$ascii
      fi
      ;;
    '[')
      if [ ${cells[$pos]} -eq 0 ]; then
        # jump forward to matching ]
        depth=1
        while [ $depth -ne 0 ]; do
          codepos=$((codepos+1))
          c=${code:$codepos:1}
          if [ "$c" = "[" ]; then depth=$((depth+1)); fi
          if [ "$c" = "]" ]; then depth=$((depth-1)); fi
        done
      fi
      ;;
    ']')
      if [ ${cells[$pos]} -ne 0 ]; then
        # jump back to matching [
        depth=1
        while [ $depth -ne 0 ]; do
          codepos=$((codepos-1))
          c=${code:$codepos:1}
          if [ "$c" = "]" ]; then depth=$((depth+1)); fi
          if [ "$c" = "[" ]; then depth=$((depth-1)); fi
        done
      fi
      ;;
  esac
  codepos=$((codepos+1))
done

