return {
  { -- Highlight, edit, and navigate code. See `:help nvim-treesitter`
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.install({
        "bash",
        "c",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "python",
        "go",
        "rust",
        "sql",
      })

      local available = ts.get_available()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("kickstart-treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          local function start()
            if not pcall(vim.treesitter.start, args.buf, lang) or args.match == "ruby" then
              return
            end
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
          if vim.list_contains(ts.get_installed(), lang) then
            start()
          elseif vim.list_contains(available, lang) then
            ts.install(lang):await(vim.schedule_wrap(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                start()
              end
            end))
          end
        end,
      })
    end,
  },
}
