set fish_greeting
abbr --add zed zeditor
eval "$(starship init fish)"
eval "$(zoxide init fish)"
#sleep so fastfetch doesnt bug width
sleep 0.1; fastfetch --logo-width 10
