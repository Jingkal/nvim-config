local M = {}

function M.run()
    local path = vim.fn.expand('%:p')

    if require('modules.moduleManager.manager').reload_this_module() then
        print(path .. " reloaded")
        return true
    end

    vim.cmd([[luafile ]] .. path)
end

function M.build()
    M.run()
end

return M
