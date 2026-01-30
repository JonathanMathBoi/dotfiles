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
        map('n', '<leader>ghs', gs.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>ghr', gs.reset_hunk, { desc = 'Reset Hunk' })
        map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })

        -- Keybinds for buffer staging
        map('n', '<leader>gfs', gs.stage_buffer, { desc = 'Stage File' })
        map('n', '<leader>gfr', gs.reset_buffer, { desc = 'Reset File' })

        -- Keybinds for git blame
        map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle Blame' })
        map('n', '<leader>gB', function()
          gs.blame_line({ full = true })
        end, { desc = 'Show Full Blame' })
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
