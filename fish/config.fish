if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH /opt/homebrew/bin $PATH
set -x PATH $PATH /Users/jkumarich/.local/bin
set -x PIP_REQUIRE_VIRTUALENV true

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv init - | source


alias l="eza"
alias ll="eza -l"
alias lll="eza -la"

zoxide init fish --cmd cd | source

