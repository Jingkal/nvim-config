local M = {}

-------------------------------------------------------------------------------------
-- Helper Function that turn path into dot path of lua 
-------------------------------------------------------------------------------------
M.path_to_dotpath = function(path)
    path         = path or vim.fn.expand('%')
    local prefix = os.getenv('HOME') .. '/.config/nvim/lua'
    local name   = nil

    if vim.startswith(path, prefix) then
        name = path:gsub(prefix .. '/', ''):gsub('.lua', ''):gsub('/', '.')
    end

    return name or path
end

----------------------------------------------------
-- return Module Names in a table ------------------
----------------------------------------------------
M.names = function()
    local ns = {}
    for n, _ in pairs(package.loaded) do
        table.insert(ns, n)
    end
    return ns
end

----------------------------------------------------
-- Remove Module By Name ---------------------------
----------------------------------------------------
M.remove = function(name)
    package.loaded[name] = nil
end

----------------------------------------------------
-- list all loaded package
----------------------------------------------------
M.list = function()
    for n, _ in pairs(package.loaded) do
        print(n)
    end
end

----------------------------------------------------
-- Find Module By Name -----------------------------
----------------------------------------------------
M.find = function(name)
    local res = nil
    for n, _ in pairs(package.loaded) do
        if n == name then
            res = n
            break
        end
    end
    print(res)
    return res
end

----------------------------------------------------
-- Show Info of Module By Name ---------------------
----------------------------------------------------
M.info = function(name)
    local module = package.loaded[name]
    if not module then
        print(nil)
        return
    end
    print(vim.inspect(module))
end

----------------------------------------------------
-- Reload Module By Name ---------------------------
----------------------------------------------------
M.reload = function(name)
    package.loaded[name] = nil
    require(name)
end

----------------------------------------------------
-- Reload Module of Current file -------------------
----------------------------------------------------
M.reload_this_module = function()
    local ft = vim.bo.filetype
    if ft ~= 'lua' then
        return false
    end

    local current_path = vim.fn.expand('%')
    local name = M.path_to_dotpath(current_path)

    if package.loaded[name] ~= nil then
        M.reload(name)
        return true
    end
    return false
end

return M
