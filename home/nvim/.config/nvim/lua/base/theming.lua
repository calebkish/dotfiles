-- Vim syntax highlighting
vim.cmd('syntax on')

-- Automatically set `filetype` option based on file extension.
vim.cmd('filetype on')

-- Loading plugin file based on filetype.
vim.cmd('filetype plugin on')

-- Loading indent file based on filetype.
vim.cmd('filetype indent on')

vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.g.gruvbox_baby_transparent_mode = false
vim.g.gruvbox_baby_telescope_theme = false
vim.g.gruvbox_baby_highlights = {
    Search = {              fg = 'NONE',    bg = '#6d442b', style = 'NONE' },
    IncSearch = {           fg = 'NONE',    bg = '#6D2B5E', style = 'underline' },
    LineNr = {              fg = '#928375', bg = 'NONE',    style = 'NONE' },
    MatchParen = {          fg = '#dedede', bg = '#665c54', style = 'NONE'},
    Comment = {             fg = '#928375', bg = 'NONE',    style = 'italic' },
    TSComment = {           fg = '#928375', bg = 'NONE',    style = 'italic' },
    SpecialComment = {      fg = '#928375', bg = 'NONE',    style = 'NONE' },
    ColorColumn = {         fg = 'NONE',    bg = '#3c3836', style = 'NONE' },
    EndOfBuffer = {         fg = '#665c54', bg = 'NONE',    style = 'NONE' },
    Visual = {              fg = 'NONE',    bg = '#365468', style = 'NONE' },
    markdownCodeBlock = {   fg = 'NONE',    bg = 'NONE',    style = 'NONE' },
    htmlEndTag = {          fg = '#87AF87', bg = 'NONE',    style = 'NONE' },
}

local colorscheme = 'gruvbox-baby'
local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('Colorscheme "' .. colorscheme .. '" could not be loaded.')
end

-- Makes backgrounds transparent
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE', ctermbg = 'NONE' })

vim.api.nvim_set_hl(0, 'ScrollbarSearch', { bg = 'NONE', fg = '#8ec07c' })
vim.api.nvim_set_hl(0, 'ScrollbarSearchHandle', { bg = '#32302F', fg = '#8ec07c' })

-- Highlight after yank
vim.api.nvim_set_hl(0, 'HighlightYank', { fg = 'NONE', bg = '#414F54' })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'init',
    callback = function()
        vim.highlight.on_yank({ higroup = "HighlightYank", timeout = 300 })
    end
})
