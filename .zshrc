# Unset variables at start of session
unset ENV_NAME
unset BRANCH
unset DEVCONTEXT

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# PyCharm CLI integration
export PATH="/Applications/PyCharm CE.app/Contents/MacOS:$PATH"

# Search in homebrew location first
export PATH="/usr/local/bin:$PATH"

# Homebrew sbin in path
export PATH="/usr/local/sbin:$PATH"

# My custom binaries
export PATH="$HOME/workspace/zsh.d/bin:$PATH"

# Kubernetes Utils
export PATH="${PATH}:${HOME}/workspace/kubectl-plugins"
export PATH="${PATH}:${HOME}/.krew/bin"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# prevent pip installs  outside of vitual env
export PIP_REQUIRE_VIRTUALENV=true

# source $HOME/workspace/zshprivate_environment_variables.sh
# set kubectl current ccontext to be docker-desktop by default
# kubectl config use-context docker-desktop >/dev/null

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="current"

# Highlighting to use for zsh autocomplete
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#9a9b9c'

# Set xterm to use 256 colours
TERM="xterm-256color"

# Not sure what this does
DEFAULT_USER=$USER

# A temporary hack for VSCode bug
# HISTFILE="$HOME/.zsh_history"

# For NVM stuff
export NVM_DIR="$HOME/.nvm"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM="${HOME}/zsh.d/custom"

# Android Studio
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk/
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# prompt_context() {}
plugins=(
  docker
  git
  pyenv
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Source custom ZSH files
for config_file in $HOME/workspace/zsh.d/custom/*.zsh; do
  source $config_file
done
unset config_file

# Source private ZSH files
for config_file in $HOME/workspace/zsh.d/private/*.zsh; do
  source $config_file
done
unset config_file

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Play nicely with `[]`
unsetopt nomatch

# enable auto complete on kubectl
source <(kubectl completion zsh)

# Pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# export PYENV_DEFAULT_PYTHON="3.9.1"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Ruby Env
eval "$(rbenv init - zsh)"

# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/deon.pearson/.sdkman"
# [[ -s "/Users/deon.pearson/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/deon.pearson/.sdkman/bin/sdkman-init.sh"
git() {
if [ "$1" = "add" -o "$1" = "stage" ]; then
    if [ "$2" = "." ] ; then
        printf "git %s . is currently disabled by your Git wrapper.
" "$1";
    else
        command git "$@";
    fi;
else
    command git "$@";
fi;
}
git() {
if [ "$1" = "add" -o "$1" = "stage" ]; then
    if [ "$2" = "." ] ; then
        printf "git %s . is currently disabled by your Git wrapper.
" "$1";
    else
        command git "$@";
    fi;
else
    command git "$@";
fi;
}
