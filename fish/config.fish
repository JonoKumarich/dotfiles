if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"

set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH $PATH $HOME/.local/bin

set -gx EDITOR nvim
set -gx VIRTUAL_ENV ".venv/"

set -gx PATH $PATH $HOME/programs/kmonad/.stack-work/install/aarch64-osx/1bd4ca6412693104f43c209161dbc9884684a9af4ae1bb87b21e5ce70772abb4/9.4.8/bin/

alias ls="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions"

set -gx MCFLY_KEY_SCHEME vim
mcfly init fish | source

zoxide init fish --cmd cd | source

fish_add_path $HOME/.spicetify

pyenv init - | source

