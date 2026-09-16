# Tool shortcuts, mirroring Omarchy's default/bash/aliases
alias h 'herdr'

function n --wraps nvim --description 'nvim, defaulting to the current directory'
    if test (count $argv) -eq 0
        command nvim .
    else
        command nvim $argv
    end
end
