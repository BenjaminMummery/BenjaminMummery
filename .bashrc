cd $HOME/Documents/Projects

# Source custom functions
if [ -e $HOME/.bash_functions ]; then
    source $HOME/.bash_functions
fi

# Colourful output from ls
export CLICOLOR=1
alias ls='ls -G'
alias ll='ls -lG'

# Python configuration
alias python=python3.8

# Quality of Life hacks
alias please='sudo $(fc -ln -1)'
alias gh='history|grep'
alias pcinit='ln -s ~/.pre-commit-config.yaml ./.pre-commit-config.yaml'
alias git_prune="git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"

# Set useful environment variables
export PYLINTRC=$HOME/.pylintrc

# Git branch info in cmd prompt
autoload -Uz vcs_info                              # Load version control system
autoload -Uz compinit && compinit

precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%b)'            # Format the vcs_info_msg_0_ variable

setopt PROMPT_SUBST                                # Set up the prompt (with git branch
PROMPT='%B% %2d%b %F{blue}${vcs_info_msg_0_}%f $ ' # name)
