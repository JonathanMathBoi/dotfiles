require("jhart.remap")
require("jhart.lazy")

local function git_commit_rulers()
    vim.opt.cc = "50,72"
end

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit" },
    callback = git_commit_rulers
})

local function vimwiki_ruler()
    vim.opt.cc = "100"
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'vimwiki' },
    callback = vimwiki_ruler
})

-- Use LSP to format file before saving
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    callback = function()
        vim.lsp.buf.format()
    end
})
