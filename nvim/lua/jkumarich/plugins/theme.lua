return {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- load at start
    priority = 1000, -- load first
    opts = {
        contrast = "hard"
    },
    config = function()
        vim.cmd([[colorscheme gruvbox]])
        vim.o.background = 'dark'
    end

}
