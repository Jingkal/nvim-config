return {
    ----------------------------------------------------
    -- return Module Names in a table ------------------
    ----------------------------------------------------
    names = function()
        local ns = {}
        for n, _ in pairs(package.loaded) do
            table.insert(ns, n)
        end
        return ns
    end,

    ----------------------------------------------------
    -- Remove Module By Name ---------------------------
    ----------------------------------------------------
    remove = function(name)
        package.loaded[name] = nil
    end,

    ----------------------------------------------------
    -- list all loaded package
    ----------------------------------------------------
    list = function()
        for n, _ in pairs(package.loaded) do
            print(n)
        end
    end,

    ----------------------------------------------------
    -- Find Module By Name -----------------------------
    ----------------------------------------------------
    find = function(name)
        local res = nil
        for n, _ in pairs(package.loaded) do
            if n == name then
                res = n
                break
            end
        end
        print(res)
        return res
    end,

    ----------------------------------------------------
    -- Show Info of Module By Name ---------------------
    ----------------------------------------------------
    info = function(name)

    end,

    ----------------------------------------------------
    -- Reload Module By Name ---------------------------
    ----------------------------------------------------
    reload = function(name)
        package.loaded[name] = nil
        require(name)
    end,
}
