starship init fish | source

abbr -a g git
abbr -a gg git grep
abbr -a be bundle exec
abbr -a bi bundle install

alias ls='lsd'

bind \cf forward-word
bind \cr isearch

set -g fish_color_cancel normal

function c
    awk $argv[1..-2] '{print $'$argv[-1]'}'
end

function each
    if string match -q -e "{}" -- $argv
        xargs -r -L1 -I{} $argv
    else
        xargs -r -L1 -I{} $argv {}
    end
end

function ev -S
    cat | source -
end

function export
    set -l s (string split -m1 = $argv)
    set -xg $s
end

function gcd
    set -l repo (ghq list | fzf-tmux -1)
    if test -n $repo
        cd (ghq root)/$repo
    end
end

function isearch
    set -l c (history | fzf-tmux --no-sort --query=(commandline))
    if test -n $c
        commandline $c
    end
end

function puts
    for a in $argv
        echo $a
    end
end
