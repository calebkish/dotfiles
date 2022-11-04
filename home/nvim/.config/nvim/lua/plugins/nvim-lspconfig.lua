-- @TODO setup json lsp schemas

local lsp_util = require('lspconfig.util')

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    return
end

local cmp_ok, cmp = pcall(require, 'cmp_nvim_lsp')
if not cmp_ok then
    return
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    P(client.name)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp.update_capabilities(capabilities)

-- === Python ===
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- === C# ===
--[[ local pid = vim.fn.getpid() ]]
--[[ local omnisharp_bin = "/home/caleb/.local/omnisharp/run" ]]
lspconfig.omnisharp.setup({
    capabilities = capabilities,
    --[[ cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }, ]]
    cmd = { 'dotnet', '/home/caleb/.local/omnisharp/OmniSharp.dll' },
    on_attach = on_attach,
})

-- === Lua ===
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local lua_ls_bin = "/home/caleb/.local/lua-language-server/bin/lua-language-server"
lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    cmd = { lua_ls_bin },
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- For: html, css, js, ts, angular, docker, markdown
-- `mkdir ~/.npm-bin &&
--  npm init &&
--  npm install dockerfile-language-server-nodejs typescript-language-server vscode-langservers-extracted`
-- Add `~/.npm-bin/node_modules/.bin/` to PATH.

-- === html ===
lspconfig.html.setup({
    -- capabilities = capabilities,
    on_attach = on_attach,
})

-- === css ===
lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- === js/ts ===
lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        'typescript-language-server',
        '--stdio',
        '--tsserver-path',
        vim.loop.cwd() .. '/node_modules/.bin/tsserver'
    }
})

-- === json ===
lspconfig.jsonls.setup({
    capabilities = capabilities,
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            end
        }
    },
    on_attach = on_attach,
})


-- === Angular ===
local ngServerCmd = {
    vim.loop.cwd() .. '/node_modules/.bin/ngserver',
    '--stdio',
    '--tsProbeLocations',
    vim.loop.cwd() .. '/node_modules',
    '--ngProbeLocations',
    vim.loop.cwd() .. '/node_modules'
}
lspconfig.angularls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lsp_util.root_pattern('angular.json'),
    cmd = ngServerCmd,
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = ngServerCmd
    end,
})

-- === Tailwind ===
lspconfig.tailwindcss.setup({})

-- === ESLint ===
lspconfig.eslint.setup({})

-- === Prisma ===
lspconfig.prismals.setup({})

-- === Docker ===
lspconfig.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

--  === null-ls ===
require('null-ls').setup({
    on_attach = on_attach,
})

local prettier = require('prettier')
prettier.setup({
    -- ["null-ls"] = {
    --     condition = function()
    --         return prettier.config_exists({
    --             check_package_json = false,
    --         })
    --     end,
    -- },
    bin = 'prettier', -- or `'prettierd'` (v0.22+)
    filetypes = {
        'css',
        'graphql',
        'html',
        'javascript',
        'javascriptreact',
        'json',
        'less',
        'markdown',
        'scss',
        'typescript',
        'typescriptreact',
        'yaml',
    },
    cli_options = {
        print_width = 80,
    },
})
