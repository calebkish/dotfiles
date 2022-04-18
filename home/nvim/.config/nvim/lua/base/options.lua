-- Number of spaces to use for each step of (auto)indent. Used for 'cindent',
-- >>, <<, etc. When zero the 'tabstop' value will be used.
vim.opt.shiftwidth = 0

-- Number of spaces that <Tab> counts for. Essentially, "    " will be
-- equivalent to "\t".
vim.opt.tabstop = 4

-- Number of spaces that <Tab> counts for while performing editing operations.
-- When negative, the value of 'shiftwidth' is used. Useful to keep 'ts' at its
-- standard value while being able to edit like it is set to 'sts'.
vim.opt.softtabstop = -1

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- <Tab> in front of a line inserts blanks according to 'shiftwidth'. <BS> will
-- delete a 'shiftwidth' worth of space at the start of the line. 'tabstop' will
-- be used in other places.
vim.opt.smarttab = true

-- Do smart indenting when starting a new line. Cases: After a line ending in
-- '{', after a line starting with a keyword from 'cinwords', before a line
-- starting with '}' (only with the "O" command).
vim.opt.smartindent = false

-- Copy indent from current line when starting a new line. 'autoindent' is
-- deferred when 'smartindent' applies.
vim.opt.autoindent = true

-- Will remove extraneous whitespace before tabs and round to 
-- multiple of 'shiftwidth'.
vim.opt.shiftround = true

vim.opt.encoding = 'utf-8'

vim.opt.scrolloff = 1000

vim.opt.hlsearch = true

vim.opt.ignorecase = true

vim.opt.smartcase = true -- case insensitive unless search contains captial letter

vim.opt.errorbells = false

vim.opt.number = true

vim.opt.clipboard:append('unnamedplus')

vim.opt.matchpairs:append('<:>')

vim.opt.wrap = false

vim.opt.sidescroll = 1

vim.opt.sidescrolloff = 5

vim.opt.listchars:append('tab:>-')

vim.opt.listchars:append('precedes:<')

vim.opt.listchars:append('extends:>')

-- shows list chars (above this line)
vim.opt.list = true

vim.opt.hidden = true

vim.opt.mouse = 'a'

vim.opt.relativenumber = true

vim.opt.nu = true

vim.opt.swapfile = false

vim.opt.backup = false

vim.opt.undofile = true

-- use vim configuration in current working directory.
vim.opt.exrc = true

vim.opt.joinspaces = false

-- Disable automatic folding.
vim.opt.foldenable = false 

vim.opt.formatoptions:remove('tro')

vim.opt.formatoptions:append('c')

vim.opt.textwidth = 80

vim.opt.wildmode = {'longest', 'list', 'full'}

vim.opt.wildmenu = true

vim.opt.wildignore:append({
    '**/.git/**',
    '**/__pycache__/**',
    '**/venv/**',
    '**/node_modules/**',
    '**/dist/**',
    '**/build/**',
    '*.o',
    '*.pyc',
    '*.swp'
})

-- Where `gf` and `:find` look for files.
vim.opt.path:remove({'/usr/include'})

-- Where commands will stop searching upward.
vim.opt.path:append({'/home/caleb'})

vim.opt.splitbelow = true

vim.opt.splitright = true

