local keymap = vim.keymap

local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
    })
end

return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = config,
    keys = {
        keymap.set('n', '<leader>ff', ':Telescope find_files<CR>'),
        keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>'),
        keymap.set('n', '<leader>fk', ':Telescope keymaps<CR>'),
        keymap.set('n', '<leader>fb', ':Telescope buffers<CR>'),
    },
}
