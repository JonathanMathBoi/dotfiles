return {
    { 'ThePrimeagen/vim-be-good' },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { 'mbbill/undotree' },
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            suppress_missing_scope = {
                projects_v2 = true,
            },
        },
    },
    { 'HiPhish/rainbow-delimiters.nvim' },
}
