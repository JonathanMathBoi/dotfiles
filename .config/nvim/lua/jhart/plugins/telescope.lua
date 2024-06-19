return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', require('telescope.builtin').find_files, desc = 'Find Files', },
        { '<leader>fg', require('telescope.builtin').live_grep,  desc = 'Live Grep', },
        { '<leader>fb', require('telescope.builtin').buffers,    desc = 'Show Buffers', },
        { '<leader>fh', require('telescope.builtin').help_tags,  desc = 'Neovim Docs', },
    },
}
