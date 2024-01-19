local keymap = vim.keymap

-- Indenting
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- Remove arrow keys. Home row only :)
keymap.set('n', '<Up>', '<Nop>', { noremap = true, silent = true })
keymap.set('n', '<Down>', '<Nop>', { noremap = true, silent = true })
keymap.set('n', '<Left>', '<Nop>', { noremap = true, silent = true })
keymap.set('n', '<Right>', '<Nop>', { noremap = true, silent = true })
keymap.set('i', '<Up>', '<Nop>', { noremap = true, silent = true })
keymap.set('i', '<Down>', '<Nop>', { noremap = true, silent = true })
keymap.set('i', '<Left>', '<Nop>', { noremap = true, silent = true })
keymap.set('i', '<Right>', '<Nop>', { noremap = true, silent = true })

-- Double leader to switch between two files
keymap.set('n', '<Leader><Leader>', '<C-^>', {noremap = true, silent = true})

-- Copy to system clipboard
keymap.set('n', '<Leader>yy', '"+yy', {noremap = true, silent = true})
keymap.set('n', '<Leader>y', '"+y', {noremap = true, silent = true})
keymap.set('v', '<Leader>y', '"+y', {noremap = true, silent = true})

-- Center view after jumps
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', 'n', 'nzz')
keymap.set('n', 'N', 'Nzz')

