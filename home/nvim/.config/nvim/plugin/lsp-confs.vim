" === pyright ===
lua << EOF
require'lspconfig'.pyright.setup{}

-- === html ===
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.html.setup {
    capabilities = capabilities,
}

-- === css ===
--Enable (broadcasting) snippet capability for completion
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

-- === Docker ===
require'lspconfig'.dotls.setup{}

-- === C# ===
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/caleb/repos/omnisharp/run"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}

EOF
