return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Keybinds for hunk staging
                map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage Hunk" })
                map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset Hunk" })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })

                -- Keybinds for buffer staging
                map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage Buffer" })
                map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset Buffer" })
            end
        },
    },
    {
        'tpope/vim-fugitive',
        keys = {
            { '<leader>gc', function() vim.cmd.Git('commit') end, desc = 'Git Commit', },
            { '<leader>gs', vim.cmd.Git,                          desc = 'Git Status', },
        },
    },
}
