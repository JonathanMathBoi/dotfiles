return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = function(_, opts)
    if (vim.g.colors_name or ''):find('catppuccin') then
      opts.highlights = require('catppuccin.special.bufferline').get_theme()
    end
  end,
}
