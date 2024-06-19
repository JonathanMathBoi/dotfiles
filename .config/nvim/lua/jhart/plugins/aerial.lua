return {
    'stevearc/aerial.nvim',
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
        { '<leader>a', '<cmd>AerialToggle!<CR>', desc = 'Open Outline', },
    },
}
