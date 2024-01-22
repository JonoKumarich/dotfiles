return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- configure python server
        lspconfig["pyright"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })

        lspconfig["rust_analyzer"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })

        lspconfig["gopls"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })

        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
    end

}

