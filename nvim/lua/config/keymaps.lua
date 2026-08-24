-- Set leader to <SPACE>
vim.g.mapleader = ' '
-- TODO: Learn what localleader is
vim.g.maplocalleader = '\\'

-- Window Commands

-- NOTE: See nvim-tmux-nav plugin for window nav keymaps
-- Set <C-direction> to move between splits
-- vim.keymap.set({ 'n', 't' }, '<C-h>', '<C-w>h')
-- vim.keymap.set({ 'n', 't' }, '<C-j>', '<C-w>j')
-- vim.keymap.set({ 'n', 't' }, '<C-k>', '<C-w>k')
-- vim.keymap.set({ 'n', 't' }, '<C-l>', '<C-w>l')

-- Window Management
vim.keymap.set('n', '<leader>wv', '<CMD>vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>wh', '<CMD>split<CR>', { desc = 'Split Window Horizontally' })
vim.keymap.set('n', '<leader>wd', '<CMD>close<CR>', { desc = 'Delete Window' })

-- Buffer Commands
vim.keymap.set('n', '<leader>bn', '<CMD>enew<CR>', { desc = 'Create New Buffer' })
vim.keymap.set({ 'n', 't' }, '<leader>bd', '<CMD>bd<CR>', { desc = 'Delete Buffer and Window' })
