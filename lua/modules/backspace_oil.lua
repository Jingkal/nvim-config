local function bs()
    if vim.api.nvim_get_option_value('modified', { buf = 0 }) then
        vim.api.nvim_err_writeln("Buffer is modified!")
        return
    end

    local bufname = vim.api.nvim_buf_get_name(0)
    if string.find(bufname, "^oil:///") then
        require("oil.actions").parent.callback()
        return
    end

    local dirname = vim.fn.getcwd()
    print(dirname)
    if bufname ~= '' then
        dirname = bufname:match("(.*[/\\])")
    end
    vim.cmd[[bd]]
    vim.cmd("Oil "..dirname)

end

return bs
