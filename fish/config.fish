if status is-interactive
    # Commands to run in interactive sessions can go here
    set PATH $HOME/.cargo/bin $PATH
end

function ll
    eza -l $argv
end
