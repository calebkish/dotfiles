lua << EOF
-- === Python ===
require'lspconfig'.pyright.setup{}

-- === C# ===
-- Get latest release `https://github.com/OmniSharp/omnisharp-roslyn/releases`
-- Extract files into `~/.omnisharp/`
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/caleb/.omnisharp/run"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}


-- For: html, css, js, ts, angular, docker
-- Optional: install nvm (and uninstall existing node and npm packages).
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
}

-- === css ===
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

-- === js/ts ===
require'lspconfig'.tsserver.setup{}

-- === json ===
require'lspconfig'.jsonls.setup {
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
        }
    }
}

-- === Angular ===
require'lspconfig'.angularls.setup{}

-- === Docker ===
require'lspconfig'.dockerls.setup{}
EOF
