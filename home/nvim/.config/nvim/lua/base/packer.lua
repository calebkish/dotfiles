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
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup()
        end
    })

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
end)

vim.cmd([[
nnoremap <Leader>xx <cmd>TroubleToggle<CR>
nnoremap <Leader>xw <cmd>TroubleToggle workspace_diagnostics<CR>
nnoremap <Leader>xd <cmd>TroubleToggle document_diagnostics<CR>
nnoremap <Leader>xq <cmd>TroubleToggle quickfix<CR>
nnoremap <Leader>xl <cmd>TroubleToggle loclist<CR>
nnoremap gR <Cmd>TroubleToggle lsp_references<CR>
]])
