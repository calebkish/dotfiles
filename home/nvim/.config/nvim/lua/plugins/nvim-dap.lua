local lib = require('lib.lib')

local dap = require('dap')
local dap_widgets = require('dap.ui.widgets')
local dapui = require('dapui')


vim.fn.sign_define('DapBreakpoint',             {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition',    {text='🔰', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint',               {text='ℹ', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped',                {text='🌟', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected',     {text='❌', texthl='', linehl='', numhl=''})

vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<leader>de', function() dap.set_exception_breakpoints({"all"}) end)
vim.keymap.set('n', '<leader>dC', function() dap.clear_breakpoints() end)

vim.keymap.set('n', '<S-F11>', function() dap.step_out() end)
vim.keymap.set('n', "<F11>", function() dap.step_into() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F8>', function() dap.continue() end)

vim.keymap.set('n', '<leader>dc', function() dap.run_to_cursor() end)

-- Need to use `restart()` because `terminate()` doesn't work with `pwa-node`
vim.keymap.set('n', '<leader>dq', function() dap.restart() end)

-- View the value for the expression under the cursor in a floating window:
vim.keymap.set('n', '<leader>di', function() dap_widgets.hover() end)

-- Go up/down in stack trace without stepping.
vim.keymap.set('n', '<leader>dk', ':lua require("dap").up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require("dap").down()<CR>zz')

-- Run the most recently used configuration.
vim.keymap.set('n', '<leader>dr', function() dap.run_last() end)

--[[ vim.keymap.set('n', '<leader>dl', function() dap.list_breakpoints() end) ]]

-- View the current scopes in a centered floating window:
--[[ vim.keymap.set('n', '<leader>d?', function() widgets.centered_float(widgets.scopes) end) ]]

--[[ -- nvim-telescope/telescope-dap.nvim ]]
--[[ require('telescope').load_extension('dap') ]]
--[[ vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>') ]]
--[[ -- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>') ]]
--[[ vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>') ]]


vim.defer_fn(function()
    require('dap.ext.vscode').load_launchjs(nil, {
        ['pwa-node'] = { 'javascript', 'typescript' },
    })
end, 1000)





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
--[[ dap.set_log_level('INFO') ]]



require('dap-vscode-js').setup({
    adapters = { 'pwa-node' },
})

for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            name = "Launch file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            name = "Attach",
            type = "pwa-node",
            request = "attach",
            processId = require('dap.utils').pick_process,
            cwd = "${workspaceFolder}",
        },
    }
end

--[[nvim-dap-virtual-text]]
require('nvim-dap-virtual-text').setup({})

--[[nvim-dap-ui]]
dapui.setup({
    mappings = {
        expand = { '<CR>', 'l', 'h' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
    },
    layouts = {
        {
            elements = {
                { id = 'breakpoints', size = 0.15 },
                { id = 'watches', size = 0.2 },
                'scopes',
            },
            size = 40,
            position = 'right',
        },
        --[[ { ]]
        --[[     elements = { ]]
        --[[         "console", ]]
        --[[     }, ]]
        --[[     size = 7, ]]
        --[[     position = "bottom", ]]
        --[[ }, ]]
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    render = {
        max_type_length = 100, -- Can be integer or nil.
        max_value_lines = 1, -- Can be integer or nil.
    }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

vim.keymap.set('n', '<F1>', function()
    dapui.toggle({ layout = 1 })
end)

vim.keymap.set('n', '<F2>', function()
    dapui.toggle({ layout = 2 })
end)

vim.keymap.set('n', '<F3>', function()
    dapui.open({ reset = true })
end)

--[[ vim.keymap.set('n', '<C-k>', function() ]]
--[[     dapui.float_element(nil, { enter = true }) ]]
--[[ end) ]]
