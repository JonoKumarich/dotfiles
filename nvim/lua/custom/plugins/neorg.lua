local M = {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = {
    "luarocks.nvim", -- this is it.
    -- "nvim-treesitter/nvim-treesitter",
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    -- "nvim-cmp",
    -- "nvim-lua/plenary.nvim",
  },
  -- build = ":Neorg sync-parsers", -- and delete this line.
  cmd = "Neorg",
}
local modules = {
  ["core.defaults"] = {},
  ["core.itero"] = {},
  ["core.completion"] = { config = { engine = "nvim-cmp", name = "neorg" } },
  ["core.integrations.nvim-cmp"] = {},
  ["core.concealer"] = { config = { icon_preset = "diamond" } },
  ["core.keybinds"] = {
    -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
    config = {
      default_keybinds = true,
      neorg_leader = ",",
    },
  },
  ["core.dirman"] = {
    config = {
      workspaces = {
        work = "~/Notes/work",
        personal = "~/Notes/personal",
      },
      default_workspace = "personal",
    },
  },
}
M.opts = {
  load = modules,
}
return M
