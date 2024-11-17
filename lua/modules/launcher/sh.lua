local M = {}

function M.run()
    local path = vim.fn.expand('%:p')
    local cmd = string.format("sh %s", path)
    require('modules.terminal').run(string.format('clear && \n %s', cmd))
end

function M.build()
    M.run()
end

return M
