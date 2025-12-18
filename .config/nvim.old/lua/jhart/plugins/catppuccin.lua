return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
        flavour = 'macchiato',
        transparent_backqround = true,
        integrations = {
            gitsigns = true,
            cmp = true,
            treesitter = true,
            telescope = {
                enabled = true
            },
            aerial = true,
            markdown = true,
            mason = true,
            vimwiki = true,
            rainbow_delimiters = true,
            octo = true,
            which_key = true,
            lsp_trouble = true,
        },
    },
    config = function(_, opts)
        require('catppuccin').setup(opts)

        vim.cmd.colorscheme("catppuccin")

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}
