local function hide_terminal()
    if vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'terminal' then
        require('modules.terminal').toggle()
        return true
    end
end
--------------------------------------------------------------------------
----- Run File -----------------------------------------------------------
--------------------------------------------------------------------------
vim.keymap.set({ 'n', 'i', 't' }, '<F5>', function()
    hide_terminal()
    local modroot = 'modules.launcher.'
    local modpath = modroot .. vim.bo.filetype
    local found, launcher = pcall(require, modpath)
    if found then
        vim.cmd [[silent w | messages clear]]
        launcher.run()
        return
    end
    vim.api.nvim_err_writeln(string.format(
        'No launcher for filetype [%s] is found!', vim.bo.filetype
    ))
end, { remap = false })

--------------------------------------------------------------------------
----- Build File ---------------------------------------------------------
--------------------------------------------------------------------------
vim.keymap.set({ 'n', 'i', 't' }, '<F7>', function()
    hide_terminal()
    local modroot = 'modules.launcher.'
    local modpath = modroot .. vim.bo.filetype
    local found, launcher = pcall(require, modpath)
    if found then
        vim.cmd [[silent w | messages clear]]
        launcher.build()
        return
    end
    vim.api.nvim_err_writeln(string.format(
        'No launcher for filetype [%s] is found!', vim.bo.filetype
    ))
end, { remap = false })
