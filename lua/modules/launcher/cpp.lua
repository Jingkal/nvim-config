-- Global
vim.g.cpp_root_marker = { 'build' }
vim.g.cpp_build_dir   = '/tmp/cppout/'

-- Buffer
vim.b.cpp_build_cmd   = 'g++ -std=c++20 -I$HOME/.local/include %s -o %s -L$HOME/.local/lib -lfmt'
vim.b.cpp_root_dir    = nil
vim.b.cpp_out_file    = nil

local M               = {}

function M.build()
    if not vim.b.cpp_root_dir then
        vim.b.cpp_root_dir = vim.fs.root(0, vim.g.cpp_root_marker)
    end

    local cmd = nil
    if vim.b.cpp_root_dir then
        -- project
        local file_basename = vim.fn.expand('%:p'):gsub(vim.b.cpp_root_dir, ''):gsub('%.%w+$', '')
        vim.b.cpp_out_file = vim.fs.joinpath(vim.b.cpp_root_dir, 'build', file_basename)
        cmd = string.format('cd %s && cmake --build build', vim.b.cpp_root_dir)
    else
        -- single file
        local file_basename = vim.fn.expand('%:t'):gsub('%.%w+$', '')
        vim.b.cpp_out_file = vim.fs.joinpath(vim.g.cpp_build_dir, file_basename)
        cmd = vim.b.cpp_build_cmd:format(vim.fn.expand('%:p'), vim.b.cpp_out_file)
    end

    require('modules.terminal').run(string.format('clear && \n %s', cmd))
end

function M.run()
    require('modules.terminal').run(string.format('clear && \n %s', vim.b.cpp_out_file))
end

vim.api.nvim_create_user_command('SetLaunchRootDir', function()
    vim.b.cpp_root_dir = vim.fn.input({
        prompt = 'CPP root dir: ',
        default = vim.b.cpp_root_dir,
        cancelreturn = '',
    })
    print('\n')
end, {})

vim.api.nvim_create_user_command('SetLaunchOutFile', function()
    vim.b.cpp_out_file = vim.fn.input({
        prompt = 'CPP out file: ',
        default = vim.b.cpp_out_file,
        cancelreturn = '',
    })
    print('\n')
end, {})

return M
