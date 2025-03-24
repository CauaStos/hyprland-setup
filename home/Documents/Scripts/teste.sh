RSYNC_OPTS="-a --checksum --mkpath"
DOTFILES_PATH=~/testecaralho/

filter=(--filter '+ chrome/***' --filter '+ zen-themes.json' --filter '- *')

rsync $RSYNC_OPTS "${filter[@]}" ~/.zen/teste/ $DOTFILES_PATH/.zen/Zen/
mkdir $DOTFILES_PATH/.zen/Zen/storage #create storage folder or else the profile is not recognized.
