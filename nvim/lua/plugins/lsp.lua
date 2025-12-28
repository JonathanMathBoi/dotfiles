return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local is_nixos = vim.fn.has('unix') == 1 and vim.fn.executable('nixos-version') == 1

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = is_nixos and {} or {
          'lua_ls',
          'ts_ls',
          'cssls',
          'jsonls',

          -- Needed for Web Dev course
          'html',
          'emmet_ls',
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Gotos
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition', buffer = ev.buf })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration', buffer = ev.buf })
          vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto Type Definition', buffer = ev.buf })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Goto References', buffer = ev.buf })
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto Implementation', buffer = ev.buf })

          -- Diagnostic Group (<leader>d)
          vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Floating Diagnostic' })
          vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Diagnostics to Quickfix' })

          -- Code Group (<leader>c)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action', buffer = ev.buf })
          vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename Symbol', buffer = ev.buf })
          vim.keymap.set('n', '<leader>cs', vim.lsp.buf.hover, { desc = 'Code Signature', buffer = ev.buf })
        end,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Lua setup (keeps 'vim' global from complaining)
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- Nix LSP
      vim.lsp.enable('nixd')

      -- Enable web deb LSPs
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('cssls')
      vim.lsp.enable('jsonls')
    end,
  },
}
