vim.keymap.set({ 'n', 'x' }, 'g=',
    function()
        local modpath = string.format("modules.formatter.%s", vim.bo.filetype)
        local found, pkg = pcall(require, modpath)
        if not found then
            vim.api.nvim_err_writeln(string.format("No formatter for %s found!", modpath))
            return
        end
        print(string.format("Formatting %s!", modpath))
        pkg.format()
    end,
    { remap = false, silent = true }
)
