if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH /opt/homebrew/bin $PATH
set -x PATH $PATH /Users/jkumarich/.local/bin
set -x PIP_REQUIRE_VIRTUALENV true

set -gx PATH $PATH /Users/jkumarich/programs/kmonad/.stack-work/install/aarch64-osx/1bd4ca6412693104f43c209161dbc9884684a9af4ae1bb87b21e5ce70772abb4/9.4.8/bin/

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv init - | source

alias l="eza"
alias ls="eza -l"
alias lsa="eza -la"

zoxide init fish --cmd cd | source

