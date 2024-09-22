local this = "modules.utils.filerunner"

vim.api.nvim_create_augroup("RunFileGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "RunFileGroup",
    pattern = { "*" },
    callback = function(ev)
        local ftrunmodule = this .. "." .. vim.bo.filetype
        local ok, mod = pcall(require, ftrunmodule)
        if ok then
            vim.keymap.set('n', '<F5>', function()
                mod.run(ev)
            end,
                { silent = true, buffer = ev.buf, noremap = true })
        else
            vim.keymap.set('n', '<F5>', function() print("Can not run filetype", vim.bo.filetype, "\nMake lua script to support this filetype.") end,
                { silent = true, buffer = ev.buf, noremap = true })
        end
    end
})
