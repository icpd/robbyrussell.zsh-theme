# robbyrussell.zsh-theme
oh-my-zsh默认主题robbyrussell添加执行时间

## Screenshot

![Screenshot.png](https://img-blog.csdnimg.cn/67529d1e9cc6406daf98ce59c0179467.png#pic_center)

## Usage

```sh
wget -O ~/.oh-my-zsh/themes/robbyrussell.zsh-theme https://raw.githubusercontent.com/icpd/robbyrussell.zsh-theme/master/robbyrussell.zsh-theme
```

## Other
修改其他主题其实原理都一样。在目标主题文件中添加以下代表：
```bash
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

```
