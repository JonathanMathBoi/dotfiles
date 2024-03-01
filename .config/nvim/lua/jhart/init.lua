require("jhart.remap")
require("jhart.lazy")
require("jhart.catppuccin")

local function git_commit_rulers()
    vim.opt.cc = "50,72"
end

vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"gitcommit"},
    callback = git_commit_rulers
})

