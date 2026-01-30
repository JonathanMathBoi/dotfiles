return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)

    wk.add({
      { '<leader>g', group = 'Git' },
      { '<leader>gh', group = 'Git Hunks' },
      { '<leader>gf', group = 'Git File' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Diagnostics' },
      { '<leader>f', group = 'Find' },
      { '<leader>h', group = 'Harpoon' },
    })
  end,
}
