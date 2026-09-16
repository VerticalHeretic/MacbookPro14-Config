# fzf file pickers, mirroring Omarchy's default/bash/aliases
# Previews run through bash (fzf otherwise uses $SHELL) and fall back to cat without bat

function ff --description 'Fuzzy-find a file with preview'
    set -l text_preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}'
    if test "$TERM" = xterm-kitty
        fzf --with-shell 'bash -c' --preview "case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) $text_preview ;; esac" $argv
    else
        fzf --with-shell 'bash -c' --preview $text_preview $argv
    end
end

function eff --description 'Pick a file with ff and open it in $EDITOR'
    set -l file (ff); or return
    $EDITOR $file
end

function sff --description 'Pick a file with ff (newest first) and scp it to a destination'
    if test (count $argv) -eq 0
        echo "Usage: sff <destination> (e.g. sff host:/tmp/)"
        return 1
    end

    # BSD stat instead of GNU find -printf
    set -l file (find . -type f -exec stat -f '%m%t%N' {} + | sort -rn | cut -f2- | ff); or return
    scp $file $argv[1]
end
