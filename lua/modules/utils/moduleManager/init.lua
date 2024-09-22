local create_cmd = vim.api.nvim_create_user_command

local mod_manager = "modules.utils.moduleManager.manager"
create_cmd('ModulesList',  function() require(mod_manager).list() end,                { nargs = 0 })
create_cmd('ModuleDel',    function(opts) require(mod_manager).remove(opts.args) end, { nargs = 1, complete = function() return require(mod_manager).names() end })
create_cmd('ModuleFind',   function(opts) require(mod_manager).find(opts.args) end,   { nargs = 1, complete = function() return require(mod_manager).names() end })
create_cmd('ModuleInfo',   function(opts) require(mod_manager).info(opts.args) end,   { nargs = 1, complete = function() return require(mod_manager).names() end })
create_cmd('ModuleReload', function(opts) require(mod_manager).reload(opts.args) end, { nargs = 1, complete = function() return require(mod_manager).names() end })

