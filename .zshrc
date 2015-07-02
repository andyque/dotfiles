# Path to your oh-my-zsh configuration.
export LANG='en_US.UTF-8'
export LC_ALL="en_US.UTF-8"
export PATH=/usr/local/bin:/usr/bin:$PATH
source ~/.bash_profile

#https://joshldavis.com/2014/07/26/oh-my-zsh-is-a-disease-antigen-is-the-vaccine/
#
# OS Detection
#

UNAME=`uname`

# Fallback info
CURRENT_OS='Linux'
DISTRO=''

if [[ $UNAME == 'Darwin' ]]; then
    CURRENT_OS='OS X'
else
    # Must be Linux, determine distro
    if [[ -f /etc/redhat-release ]]; then
        # CentOS or Redhat?
        if grep -q "CentOS" /etc/redhat-release; then
            DISTRO='CentOS'
        else
            DISTRO='RHEL'
        fi
    fi
fi

source ~/.vim/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen bundle robbyrussell/oh-my-zsh lib/

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle tmuxinator
antigen bundle osx
antigen bundle ruby
antigen bundle autojump
antigen bundle textmate
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
# don't enable this theme, it doesn't work well with ansi-term in emacs
# antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme robbyrussell
antigen theme candy

if [[ $CURRENT_OS == 'OS X' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle gem
    antigen bundle osx
elif [[ $CURRENT_OS == 'Linux' ]]; then
# None so far...

if [[ $DISTRO == 'CentOS' ]]; then
    antigen bundle centos
fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    antigen bundle cygwin
fi



[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NODE_PATH='/usr/local/lib/jsctags:${NODE_PATH}'
export GOPATH="$HOME/workspace/golang"
export GOROOT="/usr/local/Cellar/go/1.1.1"
export PATH=$PATH:$GOPATH/bin

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

# zsh
alias vim="stty stop '' -ixoff ; vim"
# `Frozing' tty, so after any command terminal settings will be restored
 ttyctl -f

 # bash
 # No ttyctl, so we need to save and then restore terminal settings
 vim()
 {
     local STTYOPTS="$(stty --save)"
     stty stop '' -ixoff
     command vim "$@"
     stty "$STTYOPTS"
 }

 alias rake="noglob rake"

 export PATH="$HOME/.cask/bin:$HOME/.cabal/bin:$PATH"

 alias e='emacsclient -t'
 alias ec='emacsclient -c'

 alias tmuxd="tmux attach -d"

 function ppgrep() {
     if [[ $1 == "" ]]; then
         PERCOL=percol
     else
         PERCOL="percol --query $1"
     fi
     ps aux | eval $PERCOL | awk '{ print $2 }'
 }

 function ppkill() {
     if [[ $1 =~ "^-" ]]; then
         QUERY=""            # options only
     else
         QUERY=$1            # with a query
         [[ $# > 0 ]] && shift
     fi
     ppgrep $QUERY | xargs kill $*
 }

 function exists { which $1 &> /dev/null }

 if exists percol; then
     function percol_select_history() {
         local tac
         exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
         BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
         CURSOR=$#BUFFER         # move cursor
         zle -R -c               # refresh
         
     }

     zle -N percol_select_history
     bindkey '^R' percol_select_history
 fi


# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT=/Users/guanghui/cocos2d-x-v2
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Users/guanghui/cocos2d-x-v2/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH


# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT=/Users/guanghui/cocos2d-x/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH:/Applications/Racket\ v6.1.1/bin

# Tell antigen that you're done.
antigen apply
