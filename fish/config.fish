if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/verticalheretic/.lmstudio/bin

pyenv init - fish | source

# Added by `rbenv init` on Wed Aug  6 15:56:27 CEST 2025
status --is-interactive; and rbenv init - --no-rehash fish | source
/Users/verticalheretic/.local/bin/mise activate fish | source
~/.local/bin/mise activate fish | source
