if test -f "$HOME/.asdf/asdf.fish"
    . $HOME/.asdf/asdf.fish
    . $HOME/.asdf/completions/asdf.fish
end

if type starship > /dev/null 2>&1
    starship init fish | source
    asdf exec direnv hook fish | source
end

if test -d $HOME/.local/bin
    set PATH "$HOME/.local/bin:$PATH"
end

abbr -a g git
abbr -a gg git grep
abbr -a be bundle exec
abbr -a bi bundle install

alias ls='lsd'
alias code='code -n'
#alias ssh='TERM=xterm /usr/bin/ssh'

bind \cf forward-word
bind \cr isearch

set -g fish_color_cancel normal

function c
    awk $argv[1..-2] '{print $'$argv[-1]'}'
end

function each
    if string match -q -e "{}" -- $argv
        xargs -r -I{} $argv
    else
        xargs -r -I{} $argv {}
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
