function hg_prompt_info {
    hg prompt --angle-brackets "\
< %{$fg[blue]%}<branch>%{$reset_color%}>\
< at %{$fg[red]%}<tags|%{$reset_color%}, >>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )>>" 2>/dev/null
}

PROMPT='%c %{$fg_bold[red]%}➜  % %{$reset_color%}'
RPROMPT='$(hg_prompt_info)$(git_prompt_info) % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""
