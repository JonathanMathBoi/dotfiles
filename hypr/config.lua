local M = {
  mod = 'SUPER',
}

function M.setup(options)
  if options and options.mod then
    M.mod = options.mod
  end
end

return M
