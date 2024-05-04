require('catppuccin').setup({
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
    }
})

vim.cmd.colorscheme "catppuccin"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
