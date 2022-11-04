local dap = require('dap')
local dap_widgets = require('dap.ui.widgets')
local dapui = require('dapui')

vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<leader>de', function() dap.set_exception_breakpoints({"all"}) end)
vim.keymap.set('n', '<leader>dC', function() dap.clear_breakpoints() end)

vim.keymap.set('n', '<S-F11>', function() dap.step_out() end)
vim.keymap.set('n', "<F11>", function() dap.step_into() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F8>', function() dap.continue() end)

vim.keymap.set('n', '<leader>dc', function() dap.run_to_cursor() end)

vim.keymap.set('n', '<leader>dq', function()
    local buf = vim.api.nvim_get_current_buf()
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    if filetype == 'cs' then
        dap.terminate()
    elseif filetype == 'javascript' or filetype == 'typescript' then
        -- Need to use `restart()` because `terminate()` doesn't work with `pwa-node`
        dap.restart()
    end
end)

-- View the value for the expression under the cursor in a floating window:
vim.keymap.set('n', '<leader>di', function() dap_widgets.hover() end)

-- Go up/down in stack trace without stepping.
vim.keymap.set('n', '<leader>dk', ':lua require("dap").up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require("dap").down()<CR>zz')

-- Run the most recently used configuration.
vim.keymap.set('n', '<leader>dr', function() dap.run_last() end)

-- View the current scopes in a centered floating window:
vim.keymap.set('n', '<leader>d?', function() dap_widgets.centered_float(dap_widgets.scopes) end)

-- vim.keymap.set('n', '<leader>ds', function()
--     local buf = dap_widgets.scopes.new_buf(function()
--         local buf = vim.api.nvim_create_buf(true, false)
--         -- vim.api.nvim_buf_set_name(buf, '\\[dap-scopes\\]')
--         return buf
--     end)
--     P(buf)
--     -- dap_widgets.builder(dap_widgets.scopes)
--     --     .new_buf(function()
--     --         local buf = vim.api.nvim_create_buf(true, false)
--     --         vim.api.nvim_buf_set_name(buf, '[dap-scopes]')
--     --         return buf
--     --     end)
--     --     .new_win(function()
--     --         vim.cmd('vsplit')
--     --         local win = vim.api.nvim_get_current_win()
--     --         return win
--     --     end)
--     --     .build()
-- end)


vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#4B4B18' })

vim.fn.sign_define('DapBreakpoint',             { texthl = '', linehl='', numhl='', text='🛑' })
vim.fn.sign_define('DapBreakpointCondition',    { texthl = '', linehl='', numhl='', text='🔰' })
vim.fn.sign_define('DapLogPoint',               { texthl = '', linehl='', numhl='', text='ℹ' })
vim.fn.sign_define('DapStopped',                { texthl = '', linehl='DapStoppedLine', numhl='', text='🌟' })
vim.fn.sign_define('DapBreakpointRejected',     { texthl = '', linehl='', numhl='', text='❌' })

dap.defaults.fallback.external_terminal = {
    command = '/usr/local/bin/st',
    args = { '-e' },
}

dap.defaults.fallback.terminal_win_cmd = function()
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, 'dapthing')
    return buf
end


-- Log file `dap.log` is in `:lua print(vim.fn.stdpath('cache'))`
-- dap.set_log_level('INFO')



-- === nvim-dap-virtual-text
require('nvim-dap-virtual-text').setup({})




-- === nvim-dap-ui ===
-- dapui.setup({
--     mappings = {
--         expand = { '<CR>', 'l', 'h' },
--         open = 'o',
--         remove = 'd',
--         edit = 'e',
--         repl = 'r',
--         toggle = 't',
--     },
--     layouts = {
--         {
--             elements = {
--                 { id = 'breakpoints', size = 0.15 },
--                 'scopes',
--             },
--             size = 40,
--             position = 'left',
--         },
--     },
--     floating = {
--         max_height = nil, -- These can be integers or a float between 0 and 1.
--         max_width = nil, -- Floats will be treated as percentage of your screen.
--         border = 'single', -- Border style. Can be "single", "double" or "rounded"
--         mappings = {
--             close = { 'q', '<Esc>' },
--         },
--     },
--     render = {
--         max_type_length = 100, -- Can be integer or nil.
--         max_value_lines = 1, -- Can be integer or nil.
--     },
-- })
--
-- dap.listeners.after.event_initialized['dapui_config'] = function()
--     dapui.open({})
-- end
--
-- dap.listeners.before.event_terminated['dapui_config'] = function()
--     dapui.close({})
-- end
--
-- dap.listeners.before.event_exited['dapui_config'] = function()
--     dapui.close({})
-- end
--
-- vim.keymap.set('n', '<F1>', function()
--     dapui.toggle({ layout = 1 })
-- end)
--
-- vim.keymap.set('n', '<F2>', function()
--     dapui.toggle({ layout = 2 })
-- end)
--
-- vim.keymap.set('n', '<F3>', function()
--     dapui.open({ reset = true })
-- end)




-- === Adapter Configurtions ===

-- JavaScript/TypeScript
require('dap-vscode-js').setup({
    adapters = { 'pwa-node' },
})

for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
        {
            name = 'Launch file (pwa-node)',
            type = 'pwa-node',
            request = 'launch',
            program = '${file}',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            name = 'Attach (pwa-node)',
            type = 'pwa-node',
            request = 'attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
        },
    }
end

-- dotnet
dap.adapters.coreclr = {
  type = 'executable',
  command = '/home/caleb/.local/dap-adapters/netcoredbg/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}
dap.configurations.cs = {
  {
    name = 'Launch (netcoredbg)',
    type = 'coreclr',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

vim.defer_fn(function()
    require('dap.ext.vscode').load_launchjs(nil, {
        ['pwa-node'] = { 'javascript', 'typescript' },
        ['coreclr'] = { 'cs' },
    })
end, 1000)
