return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    { '<leader>dt', '<CMD>Trouble diagnostics toggle<CR>', desc = 'Project Diagnostics (Trouble)' },
    { '<leader>dT', '<CMD>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)' },
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
