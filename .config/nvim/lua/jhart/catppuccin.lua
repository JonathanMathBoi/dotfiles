require('catppuccin').setup({
  flavour = 'macchiato',
  transparent_backqround = true,
  gitsigns = true,
  cmp = true,
  treesitter = true,
  telescope = {
      enabled = true
  }
})

vim.cmd.colorscheme "catppuccin"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
