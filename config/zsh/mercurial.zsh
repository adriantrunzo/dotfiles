function hg_prompt_info {
    hg prompt --angle-brackets "\
< %{$fg[blue]%}<branch>%{$reset_color%}>\
< at %{$fg[red]%}<tags|%{$reset_color%}, >>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )>>" 2>/dev/null
}
