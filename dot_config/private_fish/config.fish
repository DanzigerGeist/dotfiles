if status is-interactive
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher update
    end

    if command -sq atac
        set -gx ATAC_MAIN_DIR $HOME/.atac
        test -d $ATAC_MAIN_DIR; or mkdir -p $ATAC_MAIN_DIR
    end

    if command -sq brew
        set HB_CNF_HANDLER (brew --prefix)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
        test -f $HB_CNF_HANDLER; and source $HB_CNF_HANDLER

        function autolink_homebrew_libs
            set -l cppflags ""
            set -l ldflags ""
            set -l cgo_cflags ""
            set -l cgo_ldflags ""

            for dir in /opt/homebrew/opt/*
                if test -d "$dir/include"
                    set cppflags "$cppflags -I$dir/include"
                    set cgo_cflags "$cgo_cflags -I$dir/include"
                end
                if test -d "$dir/lib"
                    set ldflags "$ldflags -L$dir/lib"
                    set cgo_ldflags "$cgo_ldflags -L$dir/lib"
                end
            end

            set -gx CPPFLAGS "$CPPFLAGS$cppflags"
            set -gx LDFLAGS "$LDFLAGS$ldflags"
            set -gx CGO_CFLAGS "$CGO_CFLAGS$cgo_cflags"
            set -gx CGO_LDFLAGS "$CGO_LDFLAGS$cgo_ldflags"
        end

        autolink_homebrew_libs
    end

    if command -sq bun
        fish_add_path $HOME/.bun/bin
    end

    if command -sq cargo
        set -gx CARGO_HOME $HOME/.cargo
        fish_add_path $CARGO_HOME/bin
    end

    if command -sq direnv
        direnv hook fish | source
    end

    if command -sq go
        set -gx GOPATH $HOME/.go
        set -gx GOBIN $GOPATH/bin
        fish_add_path $GOBIN/
    end

    if command -sq kubectl
        set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin
    end

    if command -sq nchat
        function telegram
            TERM=xterm-256color nchat -d ~/.config/nchat/telegram $argv
        end
        function whatsapp
            TERM=xterm-256color nchat -d ~/.config/nchat/whatsapp $argv
        end
    end

    if command -sq nvim
        set -gx EDITOR nvim
    end

    if command -sq ollama
        set -gx OLLAMA_HOST http://localhost:11434
    end

    if command -sq pipx
        set -gx PIPX_BIN_DIR $HOME/.local/bin
        fish_add_path $PIPX_BIN_DIR
    end

    if command -sq thefuck
        thefuck --alias | source
    end

    if command -sq tmux
        set fish_tmux_config $HOME/.config/tmux/tmux.conf
        set fish_tmux_unicode true
        set fish_tmux_no_alias true
        set fish_tmux_fixterm true
        set fish_tmux_fixterm_with_256color xterm-256color
        set fish_tmux_fixterm_without_256color xterm
        set fish_tmux_autostart true
    end

    set sponge_purge_only_on_exit true
    set -g fish_greeting

    function ll
        ls -lAh --color=always $argv
    end
end
