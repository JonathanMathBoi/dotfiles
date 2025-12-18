return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    cmd = 'Oil',
    event = { 'VimEnter */*,.*', 'BufNew */*,.*', },
    keys = {
        { '-', vim.cmd.Oil, desc = 'Oil Parent Dir', },
    },
}
