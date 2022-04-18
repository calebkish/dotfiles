-- @TODO steup json lsp schemas

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    return
end

local status_ok, cmp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
    return
end

local lib = require('lib.lib')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
lib.map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
lib.map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
lib.map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
lib.map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    lib.buf_map(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    lib.buf_map(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    lib.buf_map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    lib.buf_map(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
    lib.buf_map(bufnr, 'n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
    lib.buf_map(bufnr, 'n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    lib.buf_map(bufnr, 'n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    lib.buf_map(bufnr, 'n', '<space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    lib.buf_map(bufnr, 'n', '<space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
    lib.buf_map(bufnr, 'n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
    lib.buf_map(bufnr, 'n', '<space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
    lib.buf_map(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        lib.buf_map(bufnr, 'n', '<space>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
    elseif client.resolved_capabilities.document_range_formatting then
        lib.buf_map(bufnr, 'n', '<space>f', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>')
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp.update_capabilities(capabilities)

-- Enable (broadcasting) snippet capability for completion
-- capabilities.textDocument.completion.completionItem.snippetSupport = true



-- === Python ===
require'lspconfig'.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}


-- === C# ===
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/caleb/.local/omnisharp/run"
require'lspconfig'.omnisharp.setup{
    capabilities = capabilities,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}


-- For: html, css, js, ts, angular, docker
-- `mkdir ~/.npm-bin &&
--  npm init &&
--  npm install @angular/language-server dockerfile-language-server-nodejs typescript typescript-language-server vscode-langservers-extracted`
-- Add `~/.npm-bin/node_modules/.bin/` to PATH.

-- === html ===
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.html.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

-- === css ===
require'lspconfig'.cssls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

-- === js/ts ===
require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

-- === json ===
require'lspconfig'.jsonls.setup {
    capabilities = capabilities,
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
        }
    },
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

-- === Angular ===
require'lspconfig'.angularls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

-- === Docker ===
require'lspconfig'.dockerls.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

