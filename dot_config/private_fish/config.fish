if status is-interactive
    set -Ux fifc_editor nvim
    set -U fish_greeting
    set -gx OLLAMA_HOST http://localhost:11434
    set -gx EDITOR nvim
    set fish_tmux_autostart true

    set HB_CNF_HANDLER (brew --prefix)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
    if test -f $HB_CNF_HANDLER
        source $HB_CNF_HANDLER
    end

    set PATH $PATH /Users/aleksyrudy/.local/bin

    thefuck --alias | source

    alias config="chezmoi edit --apply"
    alias telegram='nchat -d ~/.config/nchat/telegram'
    alias whatsapp='nchat -d ~/.config/nchat/whatsapp'
    alias mc="mc --nosubshell"
end
