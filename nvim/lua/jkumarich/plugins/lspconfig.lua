return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        require('mason').setup()
        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup {
            ensure_installed = { 
                "pyright",
            }
        }
        require("lspconfig").pyright.setup {
            capabilities = capabilities,
        }
        
        -- Keymaps
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>', opts)
        keymap.set('n', 'gR', ':Telescope lsp_references<CR>', opts)
        keymap.set('n', 'gt', ':Telescope lsp_type_definitions<CR>', opts)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    end
}
