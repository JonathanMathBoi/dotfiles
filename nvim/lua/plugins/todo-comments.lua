return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      -- This allows highlighting keywords outside of standard comments
      -- Such as TODO.md files
      comments_only = false,
    },
  },
  event = 'VeryLazy',
  keys = {
    { '<leader>ft', '<CMD>TodoTelescope<CR>', desc = 'Find Todos' },
  },
}
