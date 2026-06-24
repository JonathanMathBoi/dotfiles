return {
  'alexghergh/nvim-tmux-navigation',
  keys = {
    {
      '<C-h>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateLeft()
      end,
      desc = 'Move to Left Pane',
    },
    {
      '<C-j>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateDown()
      end,
      desc = 'Move to Lower Pane',
    },
    {
      '<C-k>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateUp()
      end,
      desc = 'Move to Upper Pane',
    },
    {
      '<C-l>',
      function()
        require('nvim-tmux-navigation').NvimTmuxNavigateRight()
      end,
      desc = 'Move to Right Pane',
    },
  },
}
