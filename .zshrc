# You can customize where you put it but it’s generally recommended that you put in $HOME/.zplug
# Essential
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh
    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi
    # Then, source plugins and add commands to $PATH
    zplug load --verbose
fi

HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')

export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh



# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/mosh", from:oh-my-zsh
# zplug "plugins/per-directory-history", from:oh-my-zsh
zplug "plugins/zsh_reload", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/shrink-path", from:oh-my-zsh
zplug "plugins/safe-paste", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "akarzim/zsh-docker-aliases"
zplug "templates/zshrc.zsh-template", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
#zplug "zsh-users/zsh-history-substring-search"
zplug "kiurchv/asdf.plugin.zsh", defer:2

zplug "larkery/zsh-histdb", lazy:true

# Syntax highlighting for commands, load last
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Theme!
zplug "themes/agnoster", from:oh-my-zsh

#export NVM_LAZY_LOAD=true
# zplug "lukechilds/zsh-nvm"

# Actually install plugins, prompt user input
# if !zplug check —verbose; then
#     printf "Install zplug plugins? [y/N]:"
#     if read -q; then
#         echo; zplug install
#     fi
# fi

zplug load


if [ -f $HOME/.zplug/repos/larkery/zsh-histdb/sqlite-history.zsh ]; then
  source $HOME/.zplug/repos/larkery/zsh-histdb/sqlite-history.zsh
fi

# if [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; then
  DEFAULT_USER=$(whoami)
# else
  # DEFAULT_USER="[user name]"
#  DEFAULT_USER=$USER
# fi
#

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# enable shrink_path
prompt_dir() {
  if type shrink_path &>/dev/null; then
    prompt_segment blue black "$(shrink_path -t -l)"
  else
    prompt_segment blue black '%~'
  fi
}

#options
setopt autocd
## Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=1000000
SAVEHIST=1000000

# # Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac
#
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY # SHARE COMMAND HISTORY DATA

# Example aliases
# alias zshconfig="mate ~/.zshrc"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias diff='colordiff'

alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s zip='unzip'
alias -s txt=$EDITOR
alias -s html=$BROWSER

alias got='git '
alias get='git '
alias icat="kitty +kitten icat"

if  [[ $('uname') == 'Darwin' ]]; then
 alias st3='~/Dropbox/Apps/st3'
 # export REACT_EDITOR='idea';
 export REACT_EDITOR='nvim';
 #source ~/.iterm2_shell_integration.zsh
  # export EDITOR='subl -w';
fi

alias vim='nvim';
alias vi='nvim';
alias v='nvim';
export EDITOR='nvim';
alias emacs='emacs -nw'
alias r='TERM=xterm-kitty ranger';

# Customize to your needs...
# export TERM=xterm-kitty
export TERM='xterm-256color'

#Key Bindings
#bindkey -M viins 'jj' vi-cmd-mode;
#bindkey -M viins \C-R history-incremental-search-backward
#bindkey -M vicmd \C-R history-incremental-search-backward
# bindkey "^R" history-incremental-search-backward

# if [ -f ~/.comp_zshrc ]; then
 [ -f ~/.comp_zshrc ] && source ~/.comp_zshrc
# fi


if [ -f $HOME/.zplug/repos/larkery/zsh-histdb/histdb-interactive.zsh ]; then
  source $HOME/.zplug/repos/larkery/zsh-histdb/histdb-interactive.zsh
  bindkey '^o' _histdb-isearch
  bindkey -M histdb-isearch '' _histdb-isearch-up
  bindkey -M histdb-isearch '^[[A' _histdb-isearch-up

  bindkey -M histdb-isearch '' _histdb-isearch-down
  bindkey -M histdb-isearch '^[[B' _histdb-isearch-down

  bindkey -M histdb-isearch '^[j' _histdb-isearch-cd

  bindkey -M histdb-isearch '^[h' _histdb-isearch-toggle-host
  bindkey -M histdb-isearch '^[d' _histdb-isearch-toggle-dir


  _zsh_autosuggest_strategy_histdb_top_here() {
      local query="select commands.argv from
  history left join commands on history.command_id = commands.rowid
  left join places on history.place_id = places.rowid
  where places.dir LIKE '$(sql_escape $PWD)%'
  and commands.argv LIKE '$(sql_escape $1)%'
  group by commands.argv order by count(*) desc limit 1"
      suggestion=$(_histdb_query "$query")
  }

  ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
  source ~/dotfiles/fzf-snippets.zsh
fi

# fzf + rg configuration
if type fzf  &> /dev/null  && type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}/*" '
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  # export FZF_DEFAULT_OPTS='
  # --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  # --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  # '
fi

function dedupHistory() {
    cp ~/.zsh_history{,-old}
    tmpFile=`mktemp`
    awk -F ";" '!seen[$2]++' ~/.zsh_history > $tmpFile
    mv $tmpFile ~/.zsh_history
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

histdb-fzf-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(histdb --sep 999 | awk -F'999' '{print $4}' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )

  LBUFFER=$selected
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  
  return $ret
}

zle     -N   histdb-fzf-widget
bindkey '^e' histdb-fzf-widget

alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor,prompt-bottom       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

