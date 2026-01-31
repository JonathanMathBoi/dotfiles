return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  event = 'VeryLazy',
  keys = {
    { '<leader>ft', '<CMD>TodoTelescope<CR>', desc = 'Find Todos' },
  },
}
