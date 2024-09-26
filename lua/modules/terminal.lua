local M = {}

function M.run(command)
    local term_buf = vim.fn.bufnr('term://*')
    local term_win = vim.fn.bufwinid(term_buf)

    -- if no terminal at current tab
    if term_win == -1 then
        M.toggle()
    else
        vim.api.nvim_set_current_win(term_win)
    end
    command = string.format('%s\n', command)
    vim.api.nvim_chan_send(vim.b.terminal_job_id, command)
end

function M.toggle()
    local term_buf = vim.fn.bufnr('term://*')
    local term_win = vim.fn.bufwinid(term_buf)

    -- if terminal WINDOW exists in CURRENT tab
    if term_win ~= -1 then
        vim.api.nvim_win_hide(term_win)
        return
    end

    -- if terminal BUFFER don't exists at all
    if term_buf == -1 then
        vim.cmd [[ split | term ]]
        return
    end

    vim.cmd [[ split ]]
    vim.api.nvim_set_current_buf(term_buf)
end

return M
