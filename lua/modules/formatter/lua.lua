-- vim.keymap.set('n', 'g=',       function() vim.lsp.buf.format { async = true } end, opts)
return {
    format = function()
        vim.lsp.buf.format { async = true }
    end
}
