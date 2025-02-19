# Install custom completions under ~/.zsh/completions
fpath=( ~/.zsh/completions $fpath )

autoload -Uz compinit promptinit colors up-line-or-beginning-search down-line-or-beginning-search url-quote-magic zmv
compinit
promptinit
colors

stty -ixon

# Use bash completions
autoload -U +X bashcompinit && bashcompinit

# Opts
setopt completealiases
setopt extendedglob
setopt correct
unset menucomplete
setopt automenu
setopt GLOB_COMPLETE

# Completion
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
# https://superuser.com/questions/415650/does-a-fuzzy-matching-mode-exist-for-the-zsh-shell
 zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# Process completion shows all processes with colors
# Usage: `kill -HUP guni<tab>` will give you list of running gunicorn processes.
# Keep pressing tab to select the process you want to HUP
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' command 'ps -A -o pid,user,cmd'
zstyle ':completion:*:*:*:*:processes' list-colors "=(#b) #([0-9]#)*=0=${color[green]}"
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'

# List all processes for killall
zstyle ':completion:*:processes-names' command "ps -eo cmd= | sed 's:\([^ ]*\).*:\1:;s:\(/[^ ]*/\)::;/^\[/d'"

# For ssh completion
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Quote urls
zle -N self-insert url-quote-magic

# VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable ALL
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:hg*:*' formats "%{$fg[blue]%}[%s:%b]%{$reset_color%} %{$fg[green]%}%u%{$reset_color%}"
zstyle ':vcs_info:git*:*' formats "%{$fg[blue]%}[%s:%b:%.6i]%{$reset_color%}%{$fg[green]%} %u %c%{$reset_color%}"
zstyle ':vcs_info:git*:*' actionformats "%{$fg[blue]%}[%s:%b:%.6i]%{$reset_color%}%{$fg[green]%} %u %c %a%{$reset_color%}"
precmd() { vcs_info }

# Prompt
setopt prompt_subst
color="green"
if [ "$USER" = "root" ]; then
  color="red"
fi;

export VIRTUAL_ENV_DISABLE_PROMPT=yes
function virtenv_indicator {
  if [[ -z $VIRTUAL_ENV ]] then
    psvar[1]=''
  else
    psvar[1]=${VIRTUAL_ENV##*/}
  fi
}
add-zsh-hook precmd virtenv_indicator

prompt='%(1j.%{$fg[red]%}[%j]%{$reset_color%}.)[%T]%{$fg[green]%}[%{$fg[$color]%}%n%{$reset_color%}%{$fg[green]%}@%M]%{$reset_color%}${vcs_info_msg_0_}
%{$fg[yellow]%}%(1V.(%1v).)%{$reset_color%}%{$fg[cyan]%}[%~]%{$reset_color%}
%(!.#.$) '

# History
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
setopt hist_ignore_all_dups
setopt share_history
setopt hist_verify
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"

# Dirstack
DIRSTACKSIZE=20
DIRSTACKFILE="$HOME/.zdirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# Key bindings
bindkey -v
bindkey -M vicmd 'k' history-beginning-search-backward-end
bindkey -M vicmd 'j' history-beginning-search-forward-end
bindkey '^w' backward-kill-word
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "^R" history-incremental-pattern-search-backward

# Borrowed from oh-my-zsh
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi

if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# Easier moving backwards
# You can do either `cd ...` or just `...` in order to `cd ../../../`
setopt auto_cd
setopt complete_aliases

rationalize-dots() {
  [[ $LBUFFER = *.. ]] && LBUFFER+=/../ || LBUFFER+=.
}

autoload rationalize-dots
zle -N rationalize-dots
bindkey . rationalize-dots

# Aliases
alias df='df -h'
alias djcompress='python manage.py compress'
alias djmigratelist='python manage.py migrate --list'
alias djmigrateshow='python manage.py showmigrations'
alias djshell='python manage.py shell'
alias djdbshell='python manage.py dbshell'
alias djstatic='python manage.py collectstatic --noinput'
alias djsuperuser='python manage.py createsuperuser'
alias djsync='python manage.py syncdb'
alias du='du -h'
alias gc="git commit -v"
alias glg='git log --graph --all --oneline'
alias glgl='git log --graph --all'
alias gst='git status -sb'
alias gsh='git log --max-count=1'
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold blue)- <%an>%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gnc='git log `git describe --tags --abbrev=0`..HEAD --oneline'
alias gnd='git diff `git describe --tags --abbrev=0`..HEAD'
alias gns='git diff `git describe --tags --abbrev=0`..HEAD --stat'
alias grep='grep --color'
alias l='ls -lah --time-style=long-iso --color=auto'
alias ll='ls -lAh --time-style=long-iso --color=auto'
alias ls='ls --time-style=long-iso --color=auto'
alias mkdir='mkdir -p'
alias pip="noglob pip"  # Allow square brackets
alias pp_json='python -mjson.tool' # curl http://foo/bar.json |pp_json for pretty print
alias pycclean="rm -rf **/*.pyc"
alias rootme="sudo -E su"
alias rootzsh="sudo -E su -s /bin/zsh"
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-synchronize="rsync -avzu --delete --progress -h"
alias rsync-update="rsync -avzu --progress -h"
alias sp="noglob salt-call publish.publish"
alias svim="sudo vim"
alias t='tail -F'
alias tail_logs="tail -F **/*.log|ccze"
alias tail_syslogs="tail -F /var/log/{messages,syslog,**/*.log}|ccze"
alias zshrc='$EDITOR ~/.zshrc'

# Global aliases
# Use as cat /tmp/file G foo
alias -g G="| grep -i --color"

# Suffix aliases
alias -s txt="vim"
alias -s rst="vim"
alias -s md="vim"
alias -s conf="vim"
alias -s sls="vim"
alias -s pp="vim"
alias -s yml="vim"

compdef rsync-copy=rsync
compdef rsync-move=rsync
compdef rsync-synchronize=rsync
compdef rsync-update=rsync
compdef _docker drun=_docker_complete_images
compdef _docker drun_bew=_docker_complete_images
compdef _docker drun_vagrant=_docker_complete_images

# Git helpers borrowed from oh-my-zsh
function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}

# In alphabetical order
alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'

alias gb='git branch'
alias gba='git branch -a'
alias gbvaa='git branch -vaa'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcl='git clone --recursive'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcmsg='git commit -m'
alias gco='git checkout'
compdef _git gco=git-checkout
alias gcount='git shortlog -sn'
compdef _git gcount
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags `git rev-list --tags --max-count=1`'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'

gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

function gfg() { git ls-files | grep $@ }
compdef _grep gfg

alias gg='git gui citool'
alias gga='git gui citool --amend'

ggf() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force origin "${b:=$1}"
}
compdef _git ggf=git-checkout

ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}
compdef _git ggl=git-checkout

ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}
compdef _git ggp=git-checkout

ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout

ggu() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout

alias ggpur='ggu'
compdef _git ggpur=git-checkout

alias ggpull='git pull origin $(git_current_branch)'
compdef _git ggpull=git-checkout

alias ggpush='git push origin $(git_current_branch)'
compdef _git ggpush=git-checkout

alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

alias ghh='git help'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef _git git-svn-dcommit-push=git

alias gk='\gitk --all --branches'
compdef _git gk='gitk'
alias gke='\gitk --all $(git log -g --pretty=%h)'
compdef _git gke='gitk'

alias gl='git pull'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"
compdef _git glp=git-log

alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpoat='git push origin --all && git push origin --tags'
compdef _git gpoat=git-push
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gsu='git submodule update'

alias gts='git tag -s'
alias gtv='git tag | sort -V'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias glum='git pull upstream master'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip--"'

# Exports
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR=vim
export DJANGO_SETTINGS_MODULE=local_settings
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Helper to view info on installed package
# Usage: $ check_package_info vim
check_package_info() {
  aptitude show $1
  apt-cache policy $1
  if read -q "REPLY?Do you want to view package changelog? [y/n] "
  then
    apt changelog $1
  fi
}

# grep for process
psgrep() {
  ps auxf|grep -v grep|grep -i --color $1
}

# grep which process is listening on given tcp-port
tcpgrep() {
  lsof -i tcp:$1
}

# Helper for creating e.g. backups. Use: "filename-$DSTAMP.bak"
export DSTAMP
currdate() {
  DSTAMP=$(date -I)
}
add-zsh-hook preexec currdate

# Display motd
if [[ -e /etc/motd ]]; then cat /etc/motd; fi
if [[ -e $HOME/.motd ]]; then cat $HOME/.motd; fi

# Package `git-flow` on Ubuntu.
if [[ -r /usr/share/git-flow/git-flow-completion.zsh ]]
then
  source /usr/share/git-flow/git-flow-completion.zsh
fi

# You can add to ~/.zsh/local.zsh your mercurial and git settings
[[ -r ~/.zsh/local.zsh ]] && . ~/.zsh/local.zsh

# Activate python virtual environment
[[ -d ~/.venv ]] && source ~/.venv/bin/activate

# Package `zsh-syntax-highlighting` on Ubuntu. Needs to be sourced at the end of this file
if [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]
then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_STYLES[default]=none
  ZSH_HIGHLIGHT_STYLES[path]=none
  ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=green"
  ZSH_HIGHLIGHT_STYLES[precommand]="fg=green"
fi

# vim: tw=0
