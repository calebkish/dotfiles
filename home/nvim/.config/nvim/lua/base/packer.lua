require('packer').startup(function(use)
    use('nvim-lua/plenary.nvim')

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

    use('kevinhwang91/nvim-hlslens')
    use('petertriho/nvim-scrollbar')

    -- doesn't work for some reason
    use({
        'tpope/vim-scriptease',
        cmd = {
            'Messages', --view messages in quickfix list
            'Verbose', -- view verbose output in preview window.
            'Time', -- measure how long it takes to run some stuff.
        },
    })

    use('voldikss/vim-floaterm')
end)

require('scrollbar').setup()
require("scrollbar.handlers.search").setup()

-- used for nvm-hlslens plugin
vim.cmd('hi default link HlSearchLens Search')


-- null-ls
-- local null_ls = require('null-ls')
--
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.diagnostics.teal
--     }
-- })
