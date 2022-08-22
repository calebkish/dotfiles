local lib = require('lib.lib')

local tree_lib = require('nvim-tree.lib')
local tree_view = require('nvim-tree.view')

local function collapse_all()
    require('nvim-tree.actions.tree-modifiers.collapse-all').fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = 'edit'
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

local function vsplit_preview()
    -- open as vsplit on current node
    local action = 'vsplit'
    local node = tree_lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
        tree_lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    tree_view.focus()
end

require('nvim-tree').setup({
    open_on_setup_file = false,
    hijack_cursor = false,
    view = {
        side = 'right',
        width = 35,
        mappings = {
            list = {
                { key = 'l', action = 'edit', action_cb = edit_or_open },
                { key = 'L', action = 'vsplit_preview', action_cb = vsplit_preview },
                { key = 'h', action = 'close_node' },
                { key = 'H', action = 'collapse_all', action_cb = collapse_all },
                { key = '<Esc>', action = 'close' },
                { key = '<C-t>', action = '' },
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
})


-- Tree background when focused
vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'NONE', ctermbg = 'NONE' })
-- Tree background when unfocused
vim.api.nvim_set_hl(0, 'NvimTreeNormalNC', { bg = 'NONE', ctermbg = 'NONE' })
-- Opened file in tree
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { bg = '#504945', ctermbg = 'NONE' })


lib.map('n', '<Localleader>e', ':NvimTreeToggle<CR>')
