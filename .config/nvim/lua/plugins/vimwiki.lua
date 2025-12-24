return {
  'vimwiki/vimwiki',
  enabled = false,
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '~/documents/vimwiki/',
        syntax = 'markdown',
        ext = '.md',
      },
    }

    vim.g.vimwiki_global_ext = 0

    local function vimwiki_ruler()
      vim.opt.cc = '100'
    end

    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = { 'vimwiki' },
      callback = vimwiki_ruler,
    })
  end,
}
