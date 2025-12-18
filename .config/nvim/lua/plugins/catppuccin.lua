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
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)

    vim.cmd.colorscheme('catppuccin')
  end,
}
