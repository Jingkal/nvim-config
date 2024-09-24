vim.g.CPP_DEFAULT_OUTPUT_DIR = '/tmp/cppout/'
vim.g.CPP_COMPILE_COMMAND_TEMPLATE = 'g++ --std=c++20 -I$HOME/.local/include %s -L$HOME/.local/lib -lfmt -o %s'

local M = {}

function M.init_singlefile()
    local filename = vim.fn.expand('%:p')
    vim.b.CPP_COMPILE_OUTFILE = string.format('%s%s.out',
        vim.g.CPP_DEFAULT_OUTPUT_DIR,
        filename:gsub('.*/', ''):gsub('%..+$', '')
    )
    vim.b.CPP_COMPILE_COMMAND = string.format(
        vim.g.CPP_COMPILE_COMMAND_TEMPLATE,
        filename,
        vim.b.CPP_COMPILE_OUTFILE
    )
    if not vim.fn.isdirectory(vim.g.CPP_DEFAULT_OUTPUT_DIR) then
        vim.fn.mkdir(vim.g.CPP_DEFAULT_OUTPUT_DIR, 'p')
    end
    if not vim.fn.isdirectory(vim.g.CPP_DEFAULT_OUTPUT_DIR) then
        vim.api.nvim_err_writeln(
            'Failed to create CPP output directory. ' ..
            vim.g.CPP_DEFAULT_OUTPUT_DIR
        )
        return false
    end
    return true
end

function M.build()
    if not M.init_singlefile() then
        return
    end
    local output = vim.fn.system(vim.b.CPP_COMPILE_COMMAND)
    if vim.v.shell_error ~= 0 then
        print(output)
    else
        print(string.format('[%s] Build success!', vim.b.CPP_COMPILE_OUTFILE))
    end
end

function M.run()
    if vim.loop.fs_stat(vim.b.CPP_COMPILE_OUTFILE) == nil then
        vim.api.nvim_err_writeln('Build file first.')
        return
    end
    local cmd = string.format('terminal %s', vim.b.CPP_COMPILE_OUTFILE)
    vim.cmd(cmd)
end

return M
