export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export PATH="$HOME/Documents/development/flutter/bin:$PATH"

set fish_greeting
abbr --add zed zeditor
eval "$(starship init fish)"
eval "$(zoxide init fish)"
enable_transience
#sleep so fastfetch doesnt bug width

if status -i;
    and sleep 0.1;
    fastfetch --logo-width 10;
end
