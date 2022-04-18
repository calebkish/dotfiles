-- Turn off vim syntax highlighting
vim.cmd('syntax off')

-- Automatically set `filetype` option based on file extension.
vim.cmd('filetype on') 

-- Disable loading plugin file based on filetype.
vim.cmd('filetype plugin off') 

-- Disable loading indent file based on filetype.
vim.cmd('filetype indent on')

vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.g.gruvbox_baby_transparent_mode = true
vim.g.gruvbox_baby_telescope_theme = false

local colorscheme = 'gruvbox-baby'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('Colorscheme "' .. colorscheme .. '" could not be loaded.')
end

-- Makes backgrounds transparent
vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
vim.cmd('highlight SignColumn guibg=NONE ctermbg=NONE')

