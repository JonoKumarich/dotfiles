if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH /opt/homebrew/bin $PATH
set -x PATH $PATH /Users/jonathankumarich/.local/bin
set -x PIP_REQUIRE_VIRTUALENV true

alias z="zoxide"

alias l="eza"
alias ll="eza -l"
alias lll="eza -la"



