require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = {'fusion', 'jsonc'}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {'markdown', 'help', 'html'}, -- list of languages that will be disabled
        additional_vim_regex_highlighting = false,
        -- use_languagetree = true,
    },
    indent = {
        enable = false,
    },
    autotag = {
        enable = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    playground = {
        enable = false,
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
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        -- swap = {
        --     enable = true,
        --     swap_next = {
        --         ["<leader>a"] = "@parameter.inner",
        --     },
        --     swap_previous = {
        --         ["<leader>A"] = "@parameter.inner",
        --     },
        -- },
        -- move = {
        --     enable = true,
        --     set_jumps = true, -- whether to set jumps in the jumplist
        --     goto_next_start = {
        --         ["]m"] = "@function.outer",
        --         ["]]"] = "@class.outer",
        --     },
        --     goto_next_end = {
        --         ["]M"] = "@function.outer",
        --         ["]["] = "@class.outer",
        --     },
        --     goto_previous_start = {
        --         ["[m"] = "@function.outer",
        --         ["[["] = "@class.outer",
        --     },
        --     goto_previous_end = {
        --         ["[M"] = "@function.outer",
        --         ["[]"] = "@class.outer",
        --     },
        -- },
        lsp_interop = {
            enable = true,
            border = 'single',
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
    },
}

vim.api.nvim_win_set_option(0, 'foldmethod', 'expr')
vim.api.nvim_win_set_option(0, 'foldexpr', 'nvim_treesitter#foldexpr()')

