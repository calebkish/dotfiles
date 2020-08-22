let mapleader =","

" Basics
	set scrolloff=1000
	set tabstop=4
	set shiftwidth=4
	set hlsearch
	syntax on
	set encoding=utf-8
	set number


" Window splitting
	set splitbelow splitright
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Disables automatic commenting on newline:
	autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
	"autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
	"autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
