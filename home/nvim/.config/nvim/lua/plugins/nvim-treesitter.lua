require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
        -- use_languagetree = true,
    },
    indent = {
        enable = false,
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    playground = {
        enable = true,
        -- disable = {},
        -- updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        -- persist_queries = false, -- Whether the query persists across vim sessions
        -- keybindings = {
        --     toggle_query_editor = 'o',
        --     toggle_hl_groups = 'i',
        --     toggle_injected_languages = 't',
        --     toggle_anonymous_nodes = 'a',
        --     toggle_language_display = 'I',
        --     focus_language = 'f',
        --     unfocus_language = 'F',
        --     update = 'R',
        --     goto_node = '<cr>',
        --     show_help = '?',
        -- },
    }
}

vim.api.nvim_win_set_option(0, 'foldmethod', 'expr')
vim.api.nvim_win_set_option(0, 'foldexpr', 'nvim_treesitter#foldexpr()')

