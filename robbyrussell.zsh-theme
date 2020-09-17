PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    if [[ $timer_show -ge $min_show_time ]]; then
      RPROMPT='%{$fg_bold[red]%}(${timer_show}s)%f%{$fg_bold[white]%}[%*]%f %{$reset_color%}%'
    else
      RPROMPT='%{$fg_bold[white]%}[%*]%f'
    fi
    unset timer
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec
add-zsh-hook precmd precmd
