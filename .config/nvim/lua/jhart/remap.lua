vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Set <C-direction> to move between splits in normal and terminal mode
vim.keymap.set({'n', 't'}, '<C-h>', '<C-w>h', {})
vim.keymap.set({'n', 't'}, '<C-j>', '<C-w>j', {})
vim.keymap.set({'n', 't'}, '<C-k>', '<C-w>k', {})
vim.keymap.set({'n', 't'}, '<C-l>', '<C-w>l', {})

