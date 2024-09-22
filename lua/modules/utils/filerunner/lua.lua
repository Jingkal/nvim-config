local M = {}

function M.init(name, buf)
    vim.b[buf].CodeMeta = {
        file = name
    }
end

function M.run(ev)
    vim.cmd[[silent! w]]
    if vim.b[ev.buf].CodeMeta == nil then
        M.init(ev.file, ev.buf)
    end
    vim.cmd('luafile ' .. vim.b[ev.buf].CodeMeta.file)
end

return M
