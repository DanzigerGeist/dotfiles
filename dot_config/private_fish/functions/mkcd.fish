function mkcd --description 'Create a directory (mkdir) and cd into it'
    if test (count $argv) -eq 0
        echo "mkcd: missing directory operand" >&2
        return 1
    end

    set -l target ""
    set -l options_done 0

    for arg in $argv
        if test $options_done -eq 0
            if test $arg = "--"
                set options_done 1
                continue
            end

            if string match -rq '^-' -- $arg
                continue
            end
        end

        set target $arg
    end

    if test -z "$target"
        echo "mkcd: unable to determine directory to enter" >&2
        return 1
    end

    command mkdir $argv
    set -l status $status
    if test $status -ne 0
        return $status
    end

    cd $target
end
