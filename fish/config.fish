if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
set -gx VIRTUAL_ENV ".venv/"
set -gx DBT_PROFILES_DIR ~/.dbt/


alias ls="eza --color=always --long --git --icons=always --no-time --no-user --no-permissions"

set -gx MCFLY_KEY_SCHEME vim
mcfly init fish | source

zoxide init fish --cmd cd | source

# uv
fish_add_path "/Users/jono.kumarich/.local/bin"

fish_add_path /Users/jono.kumarich/.local/bin

# dbt aliases
alias dbtf=/Users/jono.kumarich/.local/bin/dbt
