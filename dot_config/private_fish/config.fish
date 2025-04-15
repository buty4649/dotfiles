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
end

if type nvim > /dev/null 2>&1
    alias vim=nvim
end

if type wsl2-ssh-agent > /dev/null 2>&1
    wsl2-ssh-agent | source
end

abbr -a g git
abbr -a gg git grep
abbr -a be bundle exec
abbr -a bi bundle install
abbr -a k kubectl

alias ls='lsd'
alias c='cursor -n'
alias grep="rf -g"
alias cat='bat'

bind \cf forward-word
bind \cg forward-char

set -g fish_color_cancel normal

set -x FZF_DEFAULT_OPTS_FILE ~/.config/fzf/opts
set -x BAT_PAGER "less -FXR"

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
    set -l query (string join " " $argv)
    set -l repo (ghq list | fzf -1 --query="$query")
    if test -n $repo
        cd (ghq root)/$repo
    end
end

function puts
    for a in $argv
        echo $a
    end
end
