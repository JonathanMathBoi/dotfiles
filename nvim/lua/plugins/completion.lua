return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip', -- Required for snippets
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- Native-style bindings
        ['<C-n>'] = cmp.mapping.select_next_item(), -- Next (Native default)
        ['<C-p>'] = cmp.mapping.select_prev_item(), -- Previous (Native default)
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- "Yes" (Confirm)
        ['<C-e>'] = cmp.mapping.abort(), -- "Exit" (Abort)
        ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion

        -- Documentation scrolling
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
      }),
    })
  end,
}
