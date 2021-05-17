" completion-nvim
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_auto_popup = 1
let g:completion_confirm_key = "<CR>"

" Avoid showing message extra message when using completion
set shortmess+=c

autocmd BufEnter * lua require'completion'.on_attach()
