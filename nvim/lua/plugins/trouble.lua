return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    { '<leader>td', '<CMD>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Trouble Diagnostics (Buffer)' },
    { '<leader>tD', '<CMD>Trouble diagnostics toggle<CR>', desc = 'Trouble Diagnostics (Project)' },
    { '<leader>tt', '<CMD>Trouble todo toggle<CR>', desc = 'Trouble TODO comments' },
    {
      ']d',
      function()
        require('trouble').next({ mode = 'diagnostics', filter = { buf = 0 }, jump = true })
      end,
      desc = 'Next Diagnostic (Trouble)',
    },
    {
      '[d',
      function()
        require('trouble').prev({ mode = 'diagnostics', filter = { buf = 0 }, jump = true })
      end,
      desc = 'Previous Diagnostic (Trouble)',
    },
  },
}
