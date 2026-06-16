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
