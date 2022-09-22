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
    use('kevinhwang91/nvim-hlslens')
    use('petertriho/nvim-scrollbar')
    use('RRethy/vim-illuminate')
    use('voldikss/vim-floaterm')

    --[[Comments]]
    use('numToStr/Comment.nvim')
    use('JoosepAlviste/nvim-ts-context-commentstring')

    --[[LSP]]
    use('neovim/nvim-lspconfig')

    --[[Treesitter]]
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-textobjects')

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
require("scrollbar.handlers.search").setup()

-- used for nvm-hlslens plugin
vim.cmd('hi default link HlSearchLens Search')

-- local illuminate_color = '#353332'
-- local illuminate_color = '#514D4C'
local illuminate_color = '#464342'
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = illuminate_color, underline = false })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = illuminate_color, underline = false })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = illuminate_color, underline = false })

-- null-ls
-- local null_ls = require('null-ls')
--
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.diagnostics.teal
--     }
-- })
