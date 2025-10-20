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

        set -l cppflags
        set -l ldflags
        set -l cgo_cflags
        set -l cgo_ldflags

        for dir in /opt/homebrew/opt/*
            if test -d "$dir/include"
                set -a cppflags "-I$dir/include"
                set -a cgo_cflags "-I$dir/include"
            end

            if test -d "$dir/lib"
                set -a ldflags "-L$dir/lib"
                set -a cgo_ldflags "-L$dir/lib"
            end
        end

        if set -q cppflags[1]
            if set -q CPPFLAGS[1]
                set -gx CPPFLAGS $CPPFLAGS $cppflags
            else
                set -gx CPPFLAGS $cppflags
            end

            if set -q CGO_CFLAGS[1]
                set -gx CGO_CFLAGS $CGO_CFLAGS $cgo_cflags
            else
                set -gx CGO_CFLAGS $cgo_cflags
            end
        end

        if set -q ldflags[1]
            if set -q LDFLAGS[1]
                set -gx LDFLAGS $LDFLAGS $ldflags
            else
                set -gx LDFLAGS $ldflags
            end

            if set -q CGO_LDFLAGS[1]
                set -gx CGO_LDFLAGS $CGO_LDFLAGS $cgo_ldflags
            else
                set -gx CGO_LDFLAGS $cgo_ldflags
            end
        end
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

    if command -sq eza
        set fzf_preview_dir_cmd eza --all --color=always
        function ll
            eza -la --git --git-repos --icons=auto --color=auto $argv
        end

        function ls
            eza -l --git --git-repos --icons=auto --color=auto $argv
        end

        function lt
            eza -laT --git --git-repos --icons=auto --color=auto $argv
        end
    end

    if functions -q fzf_configure_bindings
        command stty -ixon >/dev/null 2>/dev/null

        bind -e \cs; or true
        bind -M insert -e \cs; or true

        fzf_configure_bindings \
            --directory=\csd \
            --git_log=\csl \
            --git_status=\css \
            --history=\csh \
            --processes=\csp \
            --variables=\csv
    end

    if command -sq go
        set -gx GOPATH $HOME/.go
        set -gx GOBIN $GOPATH/bin
        fish_add_path $GOBIN/
    end

    if command -sq kubectl
        if set -q KREW_ROOT
            set -l krew_bin $KREW_ROOT/.krew/bin
        else
            set -l krew_bin $HOME/.krew/bin
        end

        if test -d $krew_bin
            fish_add_path $krew_bin
        end
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

    if command -sq opam
        test -r ~/.opam/opam-init/init.fish && source ~/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
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
end
