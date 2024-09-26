-- ========================================================
-- Simpified Map function =================================
-- ========================================================
local map = function(modes, from, to, opts)
    opts = opts or { remap = false }
    vim.keymap.set(modes, from, to, opts)
end

map({'i', 'n', 'x'}, '<C-c>', '<ESC>')

-- ========================================================
-- Cursor Movement ========================================
-- ========================================================
map('i', '<C-j>', '<C-o>O')
map('i', '<C-a>', '<C-o>^')
map('i', '<C-e>', '<C-o>$')
map('i', '<C-z>', '<C-o>zz')

-- ========================================================
-- Command Mode ===========================================
-- ========================================================
map('c', '<C-A>', '<Home>',  { noremap = true })
map('c', '<C-F>', '<Right>', { noremap = true })
map('c', '<C-B>', '<Left>',  { noremap = true })

-- ========================================================
-- Vim Builtin Functions ==================================
-- ========================================================
map('n', '<C-p>', '<cmd>Oil<cr>', { noremap = true })
map('n', '<F1>',  '<ESC>:vert h ')
map('n', '<C-h>', '<cmd>tabp<cr>')
map('n', '<C-l>', '<cmd>tabn<cr>')

-- ========================================================
-- Quality of life ========================================
-- ========================================================
map({'n', 'i', 't'}, '<F4>',        '<cmd>lua require("modules.terminal").toggle()<cr>')
map('n',             '<Backspace>', '<cmd>lua require("modules.backspace_oil")()<cr>')
map('n',             '<C-_>',       '<cmd>normal gcc<cr>')
map('x',             '<C-_>',       '<cmd>normal gc<cr>')
map('n',             '<leader>;;',  '<cmd>messages<cr>')
map('n',             '<leader>;c',  '<cmd>messages clear<cr>')

-- ========================================================
-- Window Control =========================================
-- ========================================================
map('n', '<Up>',    '<cmd>resize +2<cr>',          {noremap = true, silent = true })
map('n', '<Down>',  '<cmd>resize -2<cr>',          {noremap = true, silent = true })
map('n', '<Left>',  '<cmd>vertical resize -2<cr>', {noremap = true, silent = true })
map('n', '<Right>', '<cmd>vertical resize +2<cr>', {noremap = true, silent = true })
