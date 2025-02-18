if status is-interactive
    # Bootstrap Fisher (the plugin manager).
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher update 
    end

    # Homebrew's command-not-found handler.
    set HB_CNF_HANDLER (brew --prefix)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
    if test -f $HB_CNF_HANDLER
        source $HB_CNF_HANDLER
    end

    # Global variables.
    set -gx PATH $PATH /Users/aleksyrudy/.local/bin
    set -gx OLLAMA_HOST http://localhost:11434
    set -gx EDITOR nvim

    set -U fish_greeting               # Disable the default greeting message.
    set fish_tmux_autostart true       # Automatically start tmux when opening a new terminal.
    set fish_tmux_unicode true         # Make tmux use Unicode characters.
    set fish_tmux_no_alias true        # Don't create aliases for tmux commands.
    set sponge_purge_only_on_exit true # Only purge failed commands on exit.

    # Initializing shell utils.
    thefuck --alias | source

    # Aliases.
    alias mc="mc --nosubshell"                         # Makes mc to start instantly.
    alias config="chezmoi edit --apply"                # Edit and apply the config files with chezmoi.
    alias telegram='TERM=xterm-256color nchat -d ~/.config/nchat/telegram' # Use Telegram config for nchat.
    alias whatsapp='TERM=xterm-256color nchat -d ~/.config/nchat/whatsapp' # Use WhatsApp config for nchat.
end
