local opt = vim.opt

-- Tabs / Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.relativenumber = true

-- Behaviour
opt.hidden = true
opt.scrolloff = 8
opt.errorbells = false
opt.backspace = "indent,eol,start"
opt.iskeyword:append("-")
