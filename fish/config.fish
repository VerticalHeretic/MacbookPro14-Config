if status is-interactive
    starship init fish | source
end

# Kept unguarded so non-interactive fish (scripts, fish -c) still get pyenv shims
pyenv init - fish | source

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

set -gx EDITOR nvim

set -gx GOPATH (go env GOPATH)

# PATH: fish_add_path is idempotent and skips non-existent directories
fish_add_path -P -a $GOPATH/bin $HOME/build_from_source
fish_add_path -P $HOME/.local/bin
