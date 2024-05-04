return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'ThePrimeagen/vim-be-good' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    { 'mbbill/undotree' },
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require("octo").setup()
        end
    },
    { 'HiPhish/rainbow-delimiters.nvim' },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("oil").setup()
        end,
    }
}
