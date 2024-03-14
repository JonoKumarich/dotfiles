return {
    "wincent/base16-nvim",
    lazy = false, -- load at start
    priority = 1000, -- load first
    config = function()
        vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
        vim.o.background = 'dark'
    end
}
