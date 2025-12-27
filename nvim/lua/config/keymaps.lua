-- Set leader to <SPACE>
vim.g.mapleader = ' '
-- TODO: Learn what localleader is
vim.g.maplocalleader = '\\'

-- Set <C-direction> to move between splits
vim.keymap.set({ 'n', 't' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 't' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 't' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 't' }, '<C-l>', '<C-w>l')
