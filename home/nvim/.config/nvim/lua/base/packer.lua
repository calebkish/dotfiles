require('packer').startup(function(use)
    --[[Libraries]]
    use('nvim-lua/plenary.nvim')
    use('kyazdani42/nvim-web-devicons')

    --[[Misc]]
    use('psliwka/vim-smoothie')
    use('luisiacc/gruvbox-baby')
    use('windwp/nvim-autopairs')
    use('lewis6991/impatient.nvim')
    use({
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    })
    use('kevinhwang91/nvim-hlslens') -- needed for scrollbar highlighting
    use('petertriho/nvim-scrollbar')
    use('RRethy/vim-illuminate')
    use('voldikss/vim-floaterm')
    use('Everduin94/nvim-quick-switcher')
    use('terryma/vim-multiple-cursors')
    use('kevinhwang91/nvim-bqf')
    use('ggandor/leap.nvim')

    --[[Comments]]
    use('numToStr/Comment.nvim')
    use('JoosepAlviste/nvim-ts-context-commentstring')

    --[[LSP]]
    use('neovim/nvim-lspconfig')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')

    --[[Treesitter]]
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-textobjects')
    use({ 'elgiano/nvim-treesitter-angular', branch = 'topic/jsx-fix' })

    --[[ Telescope ]]
    use('nvim-lua/popup.nvim')
    use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })
    use('nvim-telescope/telescope-fzy-native.nvim')

    --[[ Completion ]]
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/nvim-cmp')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    use('hrsh7th/cmp-nvim-lsp-signature-help')

    --[[ Debugging ]]
    use('mfussenegger/nvim-dap')
    use('nvim-telescope/telescope-dap.nvim')
    use('rcarriga/nvim-dap-ui')
    use('theHamsta/nvim-dap-virtual-text')
    use({ "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} })
    use({
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npm run compile"
    })

    --[[ Git ]]
    use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })
    -- use('pwntester/octo.nvim')
end)

require('scrollbar').setup()
require('scrollbar.handlers.search').setup()

-- used for nvm-hlslens plugin
vim.cmd('hi default link HlSearchLens Search')

-- local illuminate_color = '#353332'
-- local illuminate_color = '#514D4C'
local illuminate_color = '#464342'
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = illuminate_color, underline = false })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = illuminate_color, underline = false })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = illuminate_color, underline = false })

require('illuminate').configure({
    providers = {
        -- 'lsp',
        -- 'treesitter',
        'regex',
    },
    min_count_to_highlight = 3,
    under_cursor = true,
})


vim.cmd([[
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'

" Ignore word boundaries
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'

let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
]])

require('leap').add_default_mappings()
