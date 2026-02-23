-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Add Nix-managed plugins (e.g. treesitter parsers from programs.neovim.plugins) to rtp
-- before lazy.nvim setup, since packpath auto-loading runs after init.lua completes
for _, path in ipairs(vim.fn.globpath(vim.o.packpath, 'pack/*/start/*', 0, 1)) do
  vim.opt.rtp:append(path)
end

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    -- import plugins from lua/plugins
    { import = 'plugins' },
  },
  install = { colorscheme = { 'catppuccin' } },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- Preserve Nix-managed paths (e.g. treesitter parsers from Home Manager)
      reset = false,
    },
  },
})
