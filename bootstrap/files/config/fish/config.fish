if test -d $HOME/.local/bin
    set PATH "$HOME/.local/bin:$PATH"
end

if type mise > /dev/null 2>&1
    mise activate fish | source
    mise hook-env -s fish | source
    mise complete fish | source
end

if type starship > /dev/null 2>&1
    starship init fish | source
    #asdf exec direnv hook fish | source
end

if type nvim > /dev/null 2>&1
    alias vim=nvim
end

abbr -a g git
abbr -a gg git grep
abbr -a be bundle exec
abbr -a bi bundle install
abbr -a k kubectl

alias ls='lsd'
alias code='code -n'
#alias ssh='TERM=xterm /usr/bin/ssh'

export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

bind \cf forward-word
bind \cg forward-char
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
