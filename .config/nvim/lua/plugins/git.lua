return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- TODO: Consider adding commands to jump between hunks

        -- Keybinds for hunk staging
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Hunk' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })

        -- Keybinds for buffer staging
        map('n', '<leader>bs', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>br', gs.reset_buffer, { desc = 'Reset Buffer' })

        -- Keybinds for git blame
        map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle Blame' })
        map('n', '<leader>gB', function()
          gs.blame_line({ full = true })
        end, 'Show Full Blame')
      end,
    },
  },
  {
    'tpope/vim-fugitive',
    keys = {
      {
        '<leader>gc',
        function()
          vim.cmd.Git('commit')
        end,
        desc = 'Git Commit',
      },
      { '<leader>gs', vim.cmd.Git, desc = 'Git Status' },
    },
  },
}
