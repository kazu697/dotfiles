eval "$(mise activate zsh)"
eval "$(sheldon source)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(${HOME}/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
alias d="docker"
alias dc="docker compose"
alias g="git"
alias gs="git switch"
alias gsc="git switch -c"
alias gpl="git pull"
alias gph="git push"
alias gphf="git push --force-with-lease"
alias tf="terraform"
alias ll="ls -la"
alias lg="lazygit"
alias v="nvim"
alias vim="nvim"
alias c="claude"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/Cellar/tfenv/3.0.0/versions/1.12.2/terraform terraform

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Enable substitution in the prompt.
setopt prompt_subst

eval "$(starship init zsh)"
source <(fzf --zsh)

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf

bindkey '^g' ghq-fzf

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
