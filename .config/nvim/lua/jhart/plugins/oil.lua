return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function(_, opts)
        require('oil').setup(opts)
        vim.keymap.set('n', '-', vim.cmd.Oil)
    end,
}
