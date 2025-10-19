if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
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

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/verticalheretic/.lmstudio/bin
# End of LM Studio CLI section

# FVM
set --export PATH /Users/verticalheretic/.fvm_flutter/bin $PATH

alias flutter "fvm flutter"
alias dart "fvm dart"
