local M = {}

function M.run()
    vim.b.PYTHON_INTERPRETER = vim.b.PYTHON_INTERPRETER or 'python3'
    local path = vim.fn.expand('%:p')

    local cmd = string.format("%s %s", vim.b.PYTHON_INTERPRETER, path)
    require('modules.terminal').run(string.format('clear && \n %s', cmd))
end

function M.build()
    M.run()
end

return M
