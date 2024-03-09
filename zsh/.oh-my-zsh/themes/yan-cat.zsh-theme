# user, host, full path, and time/date on two lines for easier vgrepping

fg_x1="%F{#A769F2}"
fg_x2="%F{#A6E3A1}"
fg_x3="%F{#BAC2DE}"
fg_x4="%F{#89DCEB}"

function hg_prompt_info {
  if (( $+commands[hg] )) && [[ -e ~/.hgrc ]] && grep -q "prompt" ~/.hgrc; then
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
  fi
}

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg[blue]%} "
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "%{$fg[white]%}${ref#refs/heads/}$(git_prompt_status)$(git_prompt_short_sha)"
  fi
}

function retcode() {}

function get_git() {
  text="$(mygit)$(hg_prompt_info)"
  if [[ -n "$text" ]]; then
    echo " %{$fg_x1%}<${text}%{$fg_x1%}>"
  else
    echo " :"
  fi
}

function get_pwd() {
    echo "${PWD/$HOME/~}"
}

# alternate prompt with git & hg
PROMPT=$'%{$fg_x1%}┌─[%{$fg_x2%}%n%{$fg_x3%}@%{$reset_color%}%{$fg_x4%}%m%{$fg_x1%}]%{$reset_color%} - %{$fg_x1%}[%{$fg[yellow]%}'%D{"%m-%d %I:%M"}%b$'%{$fg_x1%}]
%{$fg_x1%}└─[%{$fg_bold[cyan]%}$(get_pwd)%{$fg_x1%}%b]$(get_git)%{$reset_color%} '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
