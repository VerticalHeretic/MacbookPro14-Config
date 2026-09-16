# Git aliases and worktree helpers, mirroring Omarchy's default/bash/aliases and fns/worktrees
alias g 'git'
alias gcm 'git commit -m'
alias gcam 'git commit -a -m'
alias gcad 'git commit -a --amend'

# Create a new worktree and branch next to the current repo, then cd into it
function ga --description 'git worktree add ../<repo>--<branch> and cd into it'
    if test (count $argv) -eq 0
        echo "Usage: ga [branch name]"
        return 1
    end

    set -l branch $argv[1]
    set -l wt_path ../(basename $PWD)--$branch

    git worktree add -b $branch $wt_path; or return 1
    command -q mise; and mise trust $wt_path
    cd $wt_path
end

# Remove the current worktree and its branch (run from inside a <repo>--<branch> worktree)
function gd --description 'Remove current worktree and its branch'
    set -l cwd $PWD
    set -l worktree (basename $cwd)

    # Protect against accidentally nuking a non-worktree directory
    if not string match -q -- '*--*' $worktree
        echo "Not in a <repo>--<branch> worktree directory"
        return 1
    end

    read -l -n 1 -P "Remove worktree and branch? [y/N] " answer
    string match -qi y -- $answer; or return 1

    # split on first `--`
    set -l parts (string split -m 1 -- -- $worktree)
    set -l root $parts[1]
    set -l branch $parts[2]

    cd ../$root
    git worktree remove $cwd --force; or return 1
    git branch -D $branch
end
