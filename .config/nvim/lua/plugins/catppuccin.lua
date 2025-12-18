return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    flavour = 'macchiato',
    transparent_background = true,
    integrations = {
      rainbow_delimiters = true,
      treesitter = true,
      lualine = true, -- Handled in lualine, but just in case catppuccin changes in future
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)

    vim.cmd.colorscheme('catppuccin')
  end,
}
