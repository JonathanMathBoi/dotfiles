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

-- Choose clipboard provider by session context
local in_tmux = vim.env.TMUX and vim.env.TMUX ~= ''
local in_ssh = vim.env.SSH_TTY and vim.env.SSH_TTY ~= ''

if in_tmux then
  -- Use tmux clipboard provider for local+tmux and ssh+tmux sessions
  vim.g.clipboard = 'tmux'
elseif in_ssh then
  -- Use OSC 52 over SSH when not in tmux
  local osc52 = require('vim.ui.clipboard.osc52')
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = osc52.copy('+'),
      ['*'] = osc52.copy('*'),
    },
    paste = {
      ['+'] = osc52.paste('+'),
      ['*'] = osc52.paste('*'),
    },
  }
end
