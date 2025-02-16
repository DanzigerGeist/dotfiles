if status is-interactive
    # Setting up Fish shell first.
    set -U fish_greeting
    set fish_tmux_autostart true
    set sponge_purge_only_on_exit true

    # Homebrew's command-not-found handler.
    set HB_CNF_HANDLER (brew --prefix)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
    if test -f $HB_CNF_HANDLER
        source $HB_CNF_HANDLER
    end

    # Other global variables.
    set -U PATH $PATH /Users/aleksyrudy/.local/bin
    set -U OLLAMA_HOST http://localhost:11434
    set -gx EDITOR nvim

    # Initializing shell utils.
    thefuck --alias | source

    # Aliases.
    alias config="chezmoi edit --apply"
    alias telegram='nchat -d ~/.config/nchat/telegram'
    alias whatsapp='nchat -d ~/.config/nchat/whatsapp'
    alias mc="mc --nosubshell"
end
