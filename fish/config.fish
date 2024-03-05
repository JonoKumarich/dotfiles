if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH /opt/homebrew/bin $PATH
set -x PATH $PATH /Users/jonathankumarich/.local/bin

pyenv init - | source



