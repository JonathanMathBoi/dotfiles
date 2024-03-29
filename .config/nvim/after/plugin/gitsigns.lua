require('gitsigns').setup({
    on_attach = function (bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Keybinds for hunk staging
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('n', '<leader>hu', gs.undo_stage_hunk)

        -- Keybinds for buffer staging
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hR', gs.reset_buffer)
    end
})

