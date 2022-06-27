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
    -- use('kyazdani42/nvim-web-devicons')
    -- use({
    --     'folke/trouble.nvim',
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function()
    --         require('trouble').setup()
    --     end
    -- })

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

    -- use('ldelossa/litee.nvim')
    -- use('ldelossa/litee-filetree.nvim')
end)

-- require('litee.lib').setup({
--     tree = {
--         icon_set = "codicons"
--     },
--     panel = {
--         orientation = "right",
--         panel_size  = 30
--     }
-- })

-- require('litee.filetree').setup()



-- null-ls
-- local null_ls = require('null-ls')
--
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.diagnostics.teal
--     }
-- })


-- Trouble.nvim
-- vim.cmd([[
-- nnoremap <Leader>xx <cmd>TroubleToggle<CR>
-- nnoremap <Leader>xw <cmd>TroubleToggle workspace_diagnostics<CR>
-- nnoremap <Leader>xd <cmd>TroubleToggle document_diagnostics<CR>
-- nnoremap <Leader>xq <cmd>TroubleToggle quickfix<CR>
-- nnoremap <Leader>xl <cmd>TroubleToggle loclist<CR>
-- nnoremap gR <Cmd>TroubleToggle lsp_references<CR>
-- ]])
