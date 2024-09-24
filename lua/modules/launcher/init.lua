--------------------------------------------------------------------------
----- Run File -----------------------------------------------------------
--------------------------------------------------------------------------
vim.keymap.set({ 'n', 'i' }, '<F5>', function()
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
end, { buffer = true, remap = false })

--------------------------------------------------------------------------
----- Build File ---------------------------------------------------------
--------------------------------------------------------------------------
vim.keymap.set({ 'n', 'i' }, '<F7>', function()
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
end, { buffer = true, remap = false })
