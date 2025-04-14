if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH $PATH $HOME/.local/bin

set -gx EDITOR nvim
set -gx VIRTUAL_ENV ".venv/"

alias ls="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions"

set -gx MCFLY_KEY_SCHEME vim
mcfly init fish | source

zoxide init fish --cmd cd | source


