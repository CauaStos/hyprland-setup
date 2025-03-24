set fish_greeting
abbr --add zed zeditor
eval "$(starship init fish)"
eval "$(zoxide init fish)"
#sleep so fastfetch doesnt bug width

if status -i;
    and sleep 0.1;
    fastfetch --logo-width 10;
end
