return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function(_, opts)
    require('telescope').setup(opts)

    -- TODO: Convert telescope binds to lazy keys
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Show Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Neovim Docs' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
  end,
}
