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

