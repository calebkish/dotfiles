local UI = require('pepita.ui')

local M = {}

M.setup = function()
    if vim.g.loaded_pepita == 1 then return end
    local user_cpoptions = vim.opt.cpoptions:get() -- save current cpoptions
    vim.cmd('set cpoptions&vim') -- reset to vim default cpoptions





    local opts = { nowait = true, noremap = true, silent = true, buffer = true }
    vim.keymap.set('n', '<localleader>l', function() UI.open_explorer() end, opts)

    local group = vim.api.nvim_create_augroup('PepitaGroup', { clear = true })
    vim.api.nvim_create_autocmd('BufEnter', { callback = function()
        -- P('in BufEnter')
    end, group = group })


    -- 'BufFilePre': before using :file or :saveas
    -- 'BufFilePost': after using :file or :saveas
    --




    vim.opt.cpoptions = user_cpoptions -- restore user coptions
    vim.g.loaded_cool = 1
end

M.setup()

return M
