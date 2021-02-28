call plug#begin(stdpath('data') . '/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'

" Dependecies: zathura, texlive
Plug 'lervag/vimtex'

" Dependencies: fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Dependencies: nodejs npm yarn
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let mapleader =","


" Basics
	set scrolloff=1000
	set tabstop=4
	set shiftwidth=4
	set nohlsearch
	set ignorecase
	set smartcase " will be case insensitive unless search contains a captial letter
	syntax on
	set encoding=utf-8
	set number
	set clipboard+=unnamedplus
	set matchpairs+=<:>
	set wrap
	set sidescroll=1
	set sidescrolloff=5
	set listchars=tab:\|\ ,precedes:<,extends:>
	set list " shows list chars (above this line)
	set shiftround " will remove extraneous whitespace before tabs and round to multiple of shiftwidth
	set hidden
	set mouse=a


" Colorscheme
	set termguicolors
	colorscheme gruvbox
	" Makes the background transparent
	hi Normal guibg=NONE ctermbg=NONE
	set colorcolumn=80


" Window splitting
	set splitbelow splitright
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l


" Tabbing
	noremap <leader>1 1gt
	noremap <leader>2 2gt
	noremap <leader>3 3gt
	noremap <leader>4 4gt
	noremap <leader>5 5gt
	noremap <leader>6 6gt
	noremap <leader>7 7gt
	noremap <leader>8 8gt
	noremap <leader>9 9gt
	noremap <leader>0 :tablast<CR>

	" Go to last active tab
	au TabLeave * let g:lasttab = tabpagenr()
	nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
	vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>


" terminal
	" Use to open terminal.
	function! OpenTerminal()
		split term://bash
		resize 10
	endfunction
	let $TERMCWD = expand('%:p:h')
	nnoremap <leader>t :call OpenTerminal()<CR>cd $TERMCWD<CR>clear<CR>

	" Exit out of terminal.
	tnoremap <leader>t <C-\><C-n>:q!<CR>

	" Start terminal in insert mode.
	au BufEnter * if &buftype == 'terminal' | :startinsert | endif

	" Easily navigate between terminal and other panes.
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l


" Replace all is aliased to S.
	"nnoremap S :%s//g<Left><Left>

" Disables automatic commenting on newline:
	autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use current init.vim version
	nmap <leader>r :so ~/.config/nvim/init.vim<CR>

" Check file in shellcheck:
	nmap <leader>s :!clear && shellcheck %<CR>

" Use a python virtual environment just for Neovim so I don't have to install "pynvim" in every virtual environment.
	let g:python3_host_prog = '/home/caleb/.venv/bin/python'
	let g:loaded_python_provider = 0

" fzf
	let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
	let g:fzf_action = {
		\ 'ctrl-t': 'tab split',
		\ 'ctrl-x': 'split',
		\ 'ctrl-v': 'vsplit',
		\}
	noremap <C-p> :Files<CR>
	if has("nvim")
		" Escape inside a FZF terminal window should exit the terminal window
		" rather than going into the terminal's normal mode.
		autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
	endif

" latex
	let g:vimtex_view_method = 'zathura'
	let g:tex_flavor = 'latex'

" COC
	let g:coc_global_extensions = [
		\ 'coc-json',
		\ 'coc-git',
		\ 'coc-tsserver',
		\ 'coc-emmet',
		\ 'coc-html',
		\ 'coc-pairs',
		\ 'coc-snippets',
		\ 'coc-prettier',
		\ 'coc-sh',
		\ 'coc-explorer',
		\ 'coc-jedi'
		\]
		"\ 'coc-markdownlint',
		"\ 'coc-vimlsp',
		"\ 'coc-pyright',


	nmap <A-f> :CocCommand explorer<CR>	

	" From Coc Readme
	set updatetime=300

	" Some servers have issues with backup files, see #649
	set nobackup
	set nowritebackup

	" don't give |ins-completion-menu| messages.
	set shortmess+=c

	" always show signcolumns
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
	" Coc only does snippet and additional edit on confirm.
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	" Or use `complete_info` if your vim support it, like:
	" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	" Remap for rename current word
	nmap <rn> <Plug>(coc-rename)

	" Remap for format selected region
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap for do codeAction of current line
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Fix autofix problem of current line
	nmap <leader>qf  <Plug>(coc-fix-current) 
	" Create mappings for function text object, requires document symbols feature of languageserver.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)

	" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')

	" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" use `:OR` for organize import of current buffer
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" Add status line support, for integration with other plugin, checkout `:h coc-status`
	"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
