return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'lua',
      'javascript',
      'css',
      'json',

      -- Needed for Web Dev course
      'html',
      'ejs',
    },
    highlights = {
      enable = true,
    },
  },
}
