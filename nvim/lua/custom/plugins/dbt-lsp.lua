-- Custom dbt LSP configuration
-- This plugin sets up a custom LSP server for dbt (data build tool) projects
-- Note: Uses a dummy plugin spec to ensure it loads AFTER the main lspconfig plugin,
--       so that LspAttach autocommands are properly registered before dbt_lsp attaches

return {
  "dbt-lsp-custom-setup",
  dir = vim.fn.stdpath("config"),
  name = "dbt-lsp-custom",

  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    local DBT_LSP_PORT = 7658

    -- Define custom dbt_lsp server if not already defined
    if not configs.dbt_lsp then
      configs.dbt_lsp = {
        default_config = {
          cmd = { vim.fn.expand("~/.config/nvim/dbt-lsp-wrapper") },
          filetypes = { "sql", "yaml" },
          root_dir = function(fname)
            return lspconfig.util.root_pattern("dbt_project.yml")(fname)
              or lspconfig.util.find_git_ancestor(fname)
          end,
          settings = {},
          name = "dbt_lsp",
        },
      }
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    lspconfig.dbt_lsp.setup({
      capabilities = capabilities,
      filetypes = { "sql", "yaml" },
      root_dir = function(fname)
        return lspconfig.util.root_pattern("dbt_project.yml")(fname)
      end,

      on_new_config = function(config, root_dir)
        config.cmd_env = vim.tbl_extend("force", config.cmd_env or {}, {
          DBT_LSP_PORT = tostring(DBT_LSP_PORT),
          DBT_PROJECT_DIR = root_dir,
          DBT_PROFILES_DIR = vim.fn.expand("~/.dbt"),
        })
      end,
    })
  end,
}
