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
vim.g.gruvbox_baby_transparent_mode = false
vim.g.gruvbox_baby_telescope_theme = false
vim.g.gruvbox_baby_highlights = {
    Search = {          fg = "fg",      bg = "#6d442b", style = "NONE" },
    IncSearch = {       fg = "fg",      bg = "#6d442b", style = "underline" },
    LineNr = {          fg = "#928375", bg = "NONE",    style = "NONE" },
    MatchParen = {      fg = "#dedede", bg = "#665c54", style = "NONE"},
    Comment = {         fg = "#928375", bg = "NONE",    style = "italic" },
    TSComment = {       fg = "#928375", bg = "NONE",    style = "italic" },
    SpecialComment = {  fg = "#928375", bg = "NONE",    style = "NONE" },
    ColorColumn = {     fg = "NONE",    bg = "#3c3836", style = "NONE" },
    EndOfBuffer = {     fg = "#665c54", bg = "NONE",    style = "NONE" },
}

local colorscheme = 'gruvbox-baby'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('Colorscheme "' .. colorscheme .. '" could not be loaded.')
end

-- Makes backgrounds transparent
vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
vim.cmd('highlight SignColumn guibg=NONE ctermbg=NONE')

