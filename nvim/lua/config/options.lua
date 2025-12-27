-- Sets line numbers on, and makes them relative
vim.opt.nu = true
vim.opt.relativenumber = true

-- Leaves 8 lines above or below current line and the terminal edge
vim.o.scrolloff = 8

-- Uses <TAB> equal to 4 spaces and related indentation settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Sensibly auto-indents
vim.opt.smartindent = true

-- Uses full color of the terminal
vim.opt.termguicolors = true

-- Allows nice copy pasting with the system clipboard
vim.opt.clipboard = 'unnamedplus'
