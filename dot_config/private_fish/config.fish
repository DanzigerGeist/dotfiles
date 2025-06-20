if status is-interactive
    # Bootstrap Fisher (the plugin manager).
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher update 
    end

    if type -q brew
        set HB_CNF_HANDLER (brew --prefix)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
    if test -f $HB_CNF_HANDLER
        source $HB_CNF_HANDLER
    end
    end

    # Homebrew's command-not-found handler.
    set HB_CNF_HANDLER (brew --prefix)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
    if test -f $HB_CNF_HANDLER
        source $HB_CNF_HANDLER
    end

    # Global variables.
    set -gx ATAC_MAIN_DIR ~/.atac/
    set -gx GOPATH $HOME/.go
    set -gx PATH $PATH $GOPATH ~/.local/bin ~/.cargo/bin
    set -gx OLLAMA_HOST http://localhost:11434
    set -gx EDITOR nvim

    set -U fish_greeting                               # Disable the default greeting message.
    set fish_tmux_unicode true                         # Make tmux use Unicode characters.
    set fish_tmux_no_alias true                        # Don't create aliases for tmux commands.
    set fish_tmux_fixterm true                         # Set the xterm compatibility mode.
    set fish_tmux_fixterm_with_256color xterm-256color # Set the xterm compatibility mode.
    set fish_tmux_fixterm_without_256color xterm       # Set the xterm compatibility mode.
    set fish_tmux_autostart false                      # Automatically start tmux when opening a new terminal. True only if tmux is installed.
    set sponge_purge_only_on_exit true                 # Only purge failed commands on exit.

    # Initializing shell utils.
    thefuck --alias | source

    # Initialize direnv.
    direnv hook fish | source

    # Create the Atac directory if it doesn't exist.
    if not test -d $ATAC_MAIN_DIR
        mkdir -p $ATAC_MAIN_DIR
    end

    # Aliases.
    alias make="gmake"                                                     # Use homebrew's GNU Make.
    alias mc="mc --nosubshell"                                             # Makes mc to start instantly.
    alias telegram='TERM=xterm-256color nchat -d ~/.config/nchat/telegram' # Use Telegram config for nchat.
    alias whatsapp='TERM=xterm-256color nchat -d ~/.config/nchat/whatsapp' # Use WhatsApp config for nchat.
    alias slack='~/.go/bin/slack-term -config ~/.config/slack-term/config' # Use Slack config for slack-term.
    alias ll='ls -lAh'
end
