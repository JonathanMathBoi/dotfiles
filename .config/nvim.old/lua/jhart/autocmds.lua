local function git_commit_rulers()
    vim.opt.cc = "50,72"
end

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit" },
    callback = git_commit_rulers
})

-- Use LSP to format file before saving
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    callback = function()
        vim.lsp.buf.format()
    end
})
