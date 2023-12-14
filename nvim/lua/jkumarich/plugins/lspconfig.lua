return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        -- configure python server
        lspconfig["pyright"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
    end

}

