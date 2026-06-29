PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

function preexec() {
  timer=${timer:-$SECONDS}
}

function format_elapsed_time() {
  local elapsed_seconds=$1
  local days=$((elapsed_seconds / 86400))
  local hours=$(((elapsed_seconds % 86400) / 3600))
  local minutes=$(((elapsed_seconds % 3600) / 60))
  local seconds=$((elapsed_seconds % 60))
  local parts=()

  (( days > 0 )) && parts+=("${days}d")
  (( hours > 0 )) && parts+=("${hours}h")
  (( minutes > 0 )) && parts+=("${minutes}m")
  (( seconds > 0 || ${#parts[@]} == 0 )) && parts+=("${seconds}s")

  echo "${(j: :)parts}"
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    if [[ $timer_show -ge $min_show_time ]]; then
      timer_show=$(format_elapsed_time $timer_show)
      RPROMPT='%{$fg_bold[red]%}(${timer_show})%f%{$fg_bold[white]%}[%*]%f %{$reset_color%}%'
    else
      RPROMPT='%{$fg_bold[white]%}[%*]%f'
    fi
    unset timer
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec
add-zsh-hook precmd precmd
