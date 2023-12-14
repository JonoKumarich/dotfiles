local config = function()
	require("nvim-treesitter.configs").setup({
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
		ensure_installed = {
			"markdown",
			"json",
			"yaml",
			"bash",
			"lua",
			"dockerfile",
			"gitignore",
			"python",
            "rust",
            "fish",
            "sql",
            "toml"
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = config
}

