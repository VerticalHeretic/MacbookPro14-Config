if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/verticalheretic/.lmstudio/bin

pyenv init - fish | source
