return {
    format = function()
        local formatter = 'black -q -'
        local mode      = vim.fn.mode()
        if mode == 'n' then
            vim.cmd(string.format("%%!%s", formatter))
        elseif mode == 'V' or mode == 'v' then
            vim.cmd('noau normal! "vy')
            local formatted = vim.fn.system(formatter, vim.fn.getreg("v"))
            vim.fn.setreg('v', formatted)
            vim.cmd('noau normal! gv"vp')
        end
    end
}
