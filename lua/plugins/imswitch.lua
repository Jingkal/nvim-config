return {
    'keaising/im-select.nvim',
    config = function()
        -- local im_opts = {
        --     default_command         = 'fcitx5-remote',
        --     default_im_select       = 1,
        --     set_default_events      = {
        --         "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave"
        --     },
        --     set_previous_events     = { "InsertEnter" },
        --     keep_quiet_on_no_binary = false,
        --     async_switch_im         = true,
        -- }
        -- local system = vim.fn.system('uname -a')
        -- if string.match(system, 'Darwin') ~= nil then
        --     im_opts.default_im_select = "com.apple.keylayout.ABC"
        --     im_opts.default_command   = 'im-select'
        -- end
        require('im_select').setup()
    end
}
