local lib = require('lib.lib')

local tree = require('nvim-tree')
local tree_lib = require('nvim-tree.lib')
local tree_view = require('nvim-tree.view')

local is_vinegar = true

local function collapse_all()
    require('nvim-tree.actions.tree-modifiers.collapse-all').fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = is_vinegar and 'edit_in_place' or 'edit'

    local node = tree_lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        tree_view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        tree_lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        tree_view.close() -- Close the tree if file was opened
    end

end

local function exit_tree()
    if is_vinegar then
        vim.cmd('exe "normal \\<C-o>"')
    else
        tree_view.close()
    end
end

local Job = require('plenary.job')
local utils = require('pepita.utils')

local function ng_generate(node, generate_type)
    local absolute_path = node.absolute_path
    if (node.type ~= 'directory') then
        absolute_path = node.parent.absolute_path
    end

    local path_in_cwd = vim.fn.substitute(absolute_path, vim.loop.cwd() .. '/', '', '')

    local angular_json_path = vim.loop.cwd() .. '/angular.json'
    local decode_ok, angular_json = pcall(vim.fn.json_decode, utils.read_file(angular_json_path))

    if (not decode_ok) then
        P('Could not decode angular.json')
        return
    end

    local project_app_paths = {}
    for project_name, project_config in pairs(angular_json.projects) do
        project_app_paths[project_name] = project_config.sourceRoot .. '/app' -- could be `src/app` or `projects/<project>/src/app`
    end

    local occupied_project = nil
    for project_name, app_path in pairs(project_app_paths) do
        local starts_with_app_path_pattern = vim.regex('^' .. app_path)
        local match = starts_with_app_path_pattern:match_str(path_in_cwd)
        if (match) then
            occupied_project = project_name
        end
    end

    if (occupied_project == nil) then
        P('Error: Not in a project')
        return
    end

    local input_ok, generate_name = pcall(vim.fn.input, 'Name: ', '', 'file')
    if (not input_ok) then
        return
    end

    local root_relative_path = vim.fn.substitute(path_in_cwd, project_app_paths[occupied_project], '', '') .. '/' .. generate_name
    if generate_type == 'component' then
        root_relative_path = project_app_paths[occupied_project] .. '/' .. generate_name
    end

    P(root_relative_path)
    Job:new({
        command = 'npm',
        args = { 'run', 'ng', 'generate', generate_type, '--', '--project', occupied_project, '--skip-import', root_relative_path }
    }):sync()
end

tree.setup({
    open_on_setup_file = false,
    hijack_cursor = false,
    view = {
        side = 'right',
        width = 35,
        mappings = {
            list = {
                { key = 'l', action = 'edit_in_place', action_cb = edit_or_open },
                { key = '<CR>', action = 'edit_in_place', action_cb = edit_or_open },
                { key = 'h', action = 'close_node' },
                { key = 'H', action = 'collapse_all', action_cb = collapse_all },

                { key = 'q', action = 'close', action_cb = exit_tree },
                { key = '<Esc>', action = 'close', action_cb = exit_tree },
                { key = '<C-c>', action = 'close', action_cb = exit_tree },

                { key = '<Leader>gc', action = 'generate_component', action_cb = function(node)
                    ng_generate(node, 'component')
                end },

                { key = '<Leader>gs', action = 'generate_service', action_cb = function(node)
                    ng_generate(node, 'service')
                end },

                { key = '<Leader>gd', action = 'generate_directive', action_cb = function(node)
                    ng_generate(node, 'directive')
                end },

                { key = '<Leader>gp', action = 'generate_pipe', action_cb = function(node)
                    ng_generate(node, 'pipe')
                end },


                { key = '<C-t>', action = '', },
                { key = '<C-e>', action = '', },
            }
        },
        preserve_window_proportions = true,
    },
    renderer = {
        highlight_git = false,
        highlight_opened_files = 'all', -- fix
        icons = {
            git_placement = 'before',
        },
        symlink_destination = false,
    },
    update_focused_file = {
        enable = true, -- a keybind to go to the focused file would be better
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
})


-- Tree background when focused
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
-- Tree background when unfocused
vim.api.nvim_set_hl(0, 'NvimTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
-- Opened file in tree
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { bg = '#504945', ctermbg = 'NONE' })


--[[ lib.map('n', '<Localleader>e', ':NvimTreeToggle<CR>') ]]

vim.keymap.set('n', '<Localleader>E', function()
    is_vinegar = false
    vim.cmd('NvimTreeToggle')
end)

vim.keymap.set('n', '<Localleader>e', function()
    is_vinegar = true
    if tree_view.is_visible() then
        --[[ tree_view.close() ]]
        vim.fn.execute('normal! \\<C-o>')
    else
        tree.open_replacing_current_buffer(vim.loop.cwd())
    end
end)
