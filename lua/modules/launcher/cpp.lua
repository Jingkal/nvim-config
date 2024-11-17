-- Global variables
vim.g.cpp_root_marker = { 'build' }
vim.g.cpp_build_dir   = '/tmp/cppout/'

-- Buffer variables
vim.b.cpp_build_cmd = 'g++ -std=c++20 -g -I$HOME/.local/include %s -o %s -L$HOME/.local/lib -lfmt'
vim.b.cpp_root_dir  = nil
vim.b.cpp_run_file  = nil
vim.b.cpp_run_args  = ''

local function findfile(name, path)
    name = name or vim.fn.expand('%:r')
    path = path or vim.fn.expand('%:p:h')
    return vim.fs.find(name, { limit = 1, path = path })[1]
end

local function prompt_for_outfile()
    vim.ui.input(
        {
            prompt = "Run file: ",
            default = vim.fn.expand('%:t:r')
        },
        function(input)
            vim.b.cpp_run_file = findfile(input, vim.b.cpp_root_dir)
        end
    )
end

local function file_exists(filepath)
    local stat = vim.loop.fs_stat(filepath)
    return stat and stat.type == 'file' or false
end

local M = {}

----------------------------------------------------------
---- Build file ------------------------------------------
----------------------------------------------------------
function M.build()
    -- set root directory
    if not vim.b.cpp_root_dir then
        vim.b.cpp_root_dir = vim.fs.root(0, vim.g.cpp_root_marker)
    end

    local cmd = nil
    if vim.b.cpp_root_dir then
        -- Project
        cmd = string.format('cd %s && cmake --build build -j4', vim.b.cpp_root_dir)
    else
        -- Single file
        cmd = vim.b.cpp_build_cmd:format(vim.fn.expand('%:p'), vim.b.cpp_run_file)
    end

    require('modules.terminal').run(string.format('clear && \n %s', cmd))
end

----------------------------------------------------------
---- Run file ------------------------------------------
----------------------------------------------------------
function M.run()
    if not vim.b.cpp_run_file or not file_exists(vim.b.cpp_run_file) then
        prompt_for_outfile()
    end

    if not vim.b.cpp_run_file then
        print(string.format('Can not find file to run: %s', vim.b.cpp_run_file))
        return
    end
    require('modules.terminal').run(string.format('clear && \n %s', vim.b.cpp_run_file))
end

----------------------------------------------------------
---- User Command: set root dir --------------------------
----------------------------------------------------------
vim.api.nvim_create_user_command('LaunchSetRootDir', function()
    vim.b.cpp_root_dir = vim.fn.input({
        prompt = 'CPP root dir: ',
        default = vim.b.cpp_root_dir,
        cancelreturn = '',
    })
    print('\n')
end, {})

----------------------------------------------------------
---- User Command: set run file --------------------------
----------------------------------------------------------
vim.api.nvim_create_user_command('LaunchSetRunFile', function()
    prompt_for_outfile()
    print(vim.b.cpp_run_file)
end, {})

----------------------------------------------------------
---- User Command: set run args --------------------------
----------------------------------------------------------
vim.api.nvim_create_user_command('LaunchSetRunArgs', function()
    vim.b.cpp_run_args = vim.fn.input({
        prompt = 'CPP Run Arguments: ',
        default = vim.b.cpp_run_file,
        cancelreturn = '',
    })
    print('\n')
end, {})

return M
