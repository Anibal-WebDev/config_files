:syntax enable
:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set nohlsearch
:set mouse=

call plug#begin('~/.vim/plugged')

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/tribela/vim-transparent' " Transparent background
Plug 'https://github.com/rstacruz/vim-closer' " For brackets autocompletion
Plug 'https://github.com/vim-python/python-syntax' " Python syntax highlighting
Plug 'ThePrimeagen/vim-be-good'
Plug 'tpope/vim-fugitive'
Plug 'navarasu/onedark.nvim'
Plug 'tpope/vim-rhubarb'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
" or                                , { 'branch': '0.1.x' }

let g:python_highlight_all = 1

" Auto-completion  For Javascript, typescript, html, jsx ...etc
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-jedi']  " list of CoC extensions needed

Plug 'jiangmiao/auto-pairs' "this will auto close ( [ { < 

" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

set encoding=UTF-8

call plug#end()

nnoremap <C-f> :NERDTreeFocus<CR>

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <C-s> :split :N<CR>
nnoremap <C-a> :vs :N<CR>
nnoremap <C-x> :bo :split <bar> :terminal bash<CR>
nnoremap <A-F> :Telescope find_files<CR>
nnoremap <A-S> :source ~/.config/nvim/init.vim<CR>
nnoremap <A-C> :colorscheme <C-D><C-R>

:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

nmap <A-!> :TagbarToggle<CR>

let g:python3_host_prog = '/usr/bin/python3'

:set completeopt=preview " For No Previews

let g:onedark_config = {
    \ 'style': 'darker',
\}

:colorscheme dracula

let g:NERDTreeWinPos = "right"
let g:NERDTreeDirArrowExpandable="|"
let g:NERDTreeDirArrowCollapsible="*"
autocmd FileType nerdtree setlocal relativenumber

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
