local lib = require('lib.lib')

lib.map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
lib.map('', '\\', '<Nop>')
vim.g.maplocalleader = '\\'

-- Stop highlighting the current search
lib.map('n', '<Esc>', ':nohlsearch<CR>:let @/ = ""<CR>')

-- Delete without polluting the clipboard register (+)
lib.map('n', '<Leader>d', '"_d')
lib.map('v', '<Leader>d', '"_d')

-- x and X no longer is put in + register
lib.map('n', 'x', '"_x')
lib.map('n', 'X', '"_X')

-- Don't do anything when <F15> is typed
lib.map('', '<F15>', '<nop>')

-- Keep things centered when moving to next/prev search match
lib.map('n', 'n', 'nzzzv')
lib.map('n', 'N', 'Nzzzv')

-- Keep the cursor in place when joining lines
lib.map('n', 'J', 'mzJ`z')

-- Keep things centered when moving to next/prev quick fix list item
lib.map('n', '<C-j>', ':cnext<CR>zzzv')
lib.map('n', '<C-k>', ':cprev<CR>zzzv')

-- Undo breakpoints (i_CTRL-G will break the current undo sequence & start an
-- undo sequence)
lib.map('i', ',', ',<C-g>u')
lib.map('i', '.', '.<C-g>u')
lib.map('i', '!', '!<C-g>u')
lib.map('i', '?', '?<C-g>u')

-- Set the ' mark (mutates the jumplist) when moving more than 5 lines away
lib.map('n', 'k', '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true })
lib.map('n', 'j', '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true })

-- Moving lines around
lib.map('v', 'J', ":m '>+1<CR>gv=gv")
lib.map('v', 'K', ":m '<-2<CR>gv=gv")
lib.map('n', '<Leader>j', ':m .+1<CR>==')
lib.map('n', '<Leader>k', ':m .-2<CR>==')

-- See global marks
-- Scuffed atm because ":norm `" doesn't show in prompt after pressing `s`
-- lib.map('n', 's', ':marks ABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>:norm `')
-- See buffers
-- lib.map('n', 'S', ':ls<CR>')

lib.map('', '<C-h>', ':wincmd h<CR>')
lib.map('', '<C-j>', ':wincmd j<CR>')
lib.map('', '<C-k>', ':wincmd k<CR>')
lib.map('', '<C-l>', ':wincmd l<CR>')

-- lib.map('n', '<C-j>', '<Cmd>cnext<CR>')
-- lib.map('n', '<C-k>', '<Cmd>cprev<CR>')
-- lib.map('n', '<C-l>', '<Cmd>lnext<CR>')
-- lib.map('n', '<C-h>', '<Cmd>lprev<CR>')


-- Keys free to map:
-- `_`
-- `R`
-- `Q`
-- `S`
-- `s`
-- `r`
-- `K` unless it has special meaning for LSP

lib.map('n', '<Leader>h', '<Cmd>so $VIMRUNTIME/syntax/hitest.vim<CR>')

vim.cmd([[
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
]])

lib.map('n', '<Leader>x', ':silent write<CR>:source %<CR>')
