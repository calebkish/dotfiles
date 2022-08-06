require('packer').startup(function(use)
    use('nvim-lua/plenary.nvim')

    use('tpope/vim-surround')
    use('psliwka/vim-smoothie')
    use('luisiacc/gruvbox-baby')
    use('windwp/nvim-autopairs')
    use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })

    use('numToStr/Comment.nvim')
    use('JoosepAlviste/nvim-ts-context-commentstring')

    use('neovim/nvim-lspconfig')
    use('kyazdani42/nvim-web-devicons')

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-textobjects')

    use('nvim-lua/popup.nvim')
    use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })
    use('nvim-telescope/telescope-fzy-native.nvim')

    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/nvim-cmp')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/cmp-nvim-lsp-signature-help')

    use('mfussenegger/nvim-dap')
    use('rcarriga/nvim-dap-ui')
    use('theHamsta/nvim-dap-virtual-text')

    -- use('pwntester/octo.nvim')

    use('tpope/vim-fugitive')

    use('lewis6991/impatient.nvim')

    -- use('jose-elias-alvarez/null-ls.nvim')

    use({
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    })

    use('akinsho/bufferline.nvim')
end)

local my_lib = require('lib.lib')

my_lib.map('n', '<Leader>s', ':BufferLinePick<CR>')
my_lib.map('n', '<Leader>S', ':BufferLinePickClose<CR>')


local lib = require('nvim-tree.lib')
local view = require('nvim-tree.view')

local function collapse_all()
    require('nvim-tree.actions.tree-modifiers.collapse-all').fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = 'edit'
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
        view.close() -- Close the tree if file was opened

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
        view.close() -- Close the tree if file was opened
    end

end

local function vsplit_preview()
    -- open as vsplit on current node
    local action = 'vsplit'
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
        require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)

    else
        require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    view.focus()
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
                { key = 'H', action = 'collapse_all', action_cb = collapse_all }
            }
        }
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

my_lib.map('n', '<Localleader>e', ':NvimTreeToggle<CR>')


-- null-ls
-- local null_ls = require('null-ls')
--
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.diagnostics.teal
--     }
-- })
