# Source Global Bash Completion
if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

PATH=$PATH:$HOME/scripts/bin

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

#===============================#
# 	Alias            			#
#===============================#

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto'
alias ll='ls -lh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto'
alias la='ls -lha --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto'
alias grep='grep --color=tty -d skip'
alias cp='cp -i'                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias du='du -h'
alias free='free -m'                      # show sizes in MB
alias ping='ping -c 5'
alias np='nano PKGBUILD'

#===============================#
#	Functions		            #
#===============================#

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# cds - Change directory and list
# usage: cds <path>
cds ()
{
  if [ -d $1 ]; then
    cd $1
    ls ./
  else
    echo "'$1' does not exist"
  fi
}

#===============================#
#    Prompt            			#
#===============================#

# Original
#PS1='[\u@\h \W]$ '

# Custom
PS1='\[\e[0;36m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;37m\]\$\[\e[m\] \[\e[0m\]'
#PS1="[\[\e[36m\u\e[0m@\e[37m\h\e[0m\]]$ "

