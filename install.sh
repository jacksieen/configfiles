#!/bin/sh
copy_file () {
  if [ -e $1 ]
  then
    cp $1 ~/.$1
  fi
}

update_zsh () {
  ZSHDIR=~/.oh-my-zsh/
  if [ -e $ZSHDIR ]
  then
    if [ -e $ZSHDIR/.git ]
    then
      echo updating oh-my-zsh...
      cd $ZSHDIR
      git pull origin master > /dev/null 2>&1
      cd - > /dev/null 2>&1
    else
      echo wrong with oh-my-zsh
    fi
  else
    echo installing oh-my-zsh
    git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSHDIR > /dev/null 2>&1
  fi
}

install_vundle() {
  VUNDLE=~/.vim/Vundle.vim/
    if [ -e $VUNDLE ]
    then
      if [ -e $VUNDLE/.git ]
      then
        echo updating VundleVim
        cd $VUNDLE
        git pull origin master > /dev/null 2>&1
        cd - > /dev/null 2>&1
      else
        echo wrong with VundleVim
      fi
    else
      echo installing VundleVim
      git clone https://github.com/VundleVim/Vundle.vim $VUNDLE > /dev/null 2>&1
      echo "** run 'PluginInstall' at vim cmd **"
    fi
}

if [ $# -eq 0 ]
then
  echo "usage: install.sh all|vimrc|tmux|zsh"
else
  while [ $# -gt 0 ]
  do
    case $1 in
      vimrc)
        copy_file vimrc
        install_vundle
        ;;
      tmux)
        copy_file tmux.conf
        ;;
      zshrc)
        copy_file zshrc
        update_zsh
        ;;
      all)
        copy_file vimrc
        install_vundle
        copy_file tmux.conf
        copy_file zshrc
        update_zsh
        ;;
      *)
        printf "error usage \"%s\"\n" $1
        ;;
    esac
    shift
  done
fi
