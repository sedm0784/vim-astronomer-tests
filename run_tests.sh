#!/bin/bash
REAL_HOME=$HOME
HOME=/dev/null vim -i NONE -c "Vader! *.vader" -Nu <(cat << VIMRC
filetype off
set runtimepath+=$REAL_HOME/.vim/bundle/vader
set runtimepath+=$REAL_HOME/.vim/bundle/vim-astronomer
filetype plugin indent on
syntax enable
VIMRC)
result=$?
if [ $result -eq 0 ]
then
  echo "TESTS PASSED"
else
  echo "TESTS FAILED"
fi
