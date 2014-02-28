" editor
set nocompatible
set number
set autoindent
set fileencoding=utf-8
set encoding=utf8
set fileformats=unix,dos,mac
set fileformat=unix
set listchars=tab:>-,trail:-,eol:↲,nbsp:%,extends:>,precedes:<
set list
set tabstop=4
set shiftwidth=4
set laststatus=2
set statusline=%<%F\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set showcmd
set showmatch
set hlsearch
set ignorecase
set smartcase
set wrapscan


" php
" au BufNewFile,BufRead *.php set tags+=$HOME/php.tags
au BufNewFile,BufRead *.php set dictionary=~/.vim/dict/php.dict
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PmenuSBar ctermbg=4

" NeoBundle
if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Shougo/vimshell'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'surround.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'jdonaldson/vaxe'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'osyo-manga/vim-precious'
NeoBundle 'majutsushi/tagbar'

"your other plugins
"NeoBundleCheck

filetype plugin indent on

" matchit
:source $VIMRUNTIME/macros/matchit.vim

" syntastic
" require node,jslint
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript'], 'passive_filetypes': ['html']}
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checker = 'jshint'

" map
map ; :

" Memo Launcher
command Memo edit ~/.memo.markdown
command Suw w !sudo tee > /dev/null %

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2 
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

inoremap <expr><C-g>	neocomplete#undo_completion()
inoremap <expr><C-l>	neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
endfunction

inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" viminfo
set viminfo='100,<50,s10,h,%

" backup 
set backup
set backupdir=$HOME/.vim/backup
let $directory = $bacupdir

" |cw
autocmd QuickFixCmdPost *grep* cwindow

" colorscheme
syntax on
set background=dark
colorscheme solarized

" Vaxe
" http://qiita.com/hatchinee/items/adb0b447bd1118ceb1eb
" set autogroup
augroup MyAutoCmd
	autocmd!
augroup END

" vaxeの動作にはautowriteを有効にする必要がある
autocmd MyAutoCmd FileType haxe
	\ setl autowrite
autocmd MyAutoCmd FileType hxml
	\ setl autowrite
autocmd MyAutoCmd FileType nmml.xml
	\ setl autowrite

let g:vaxe_haxe_version = 3

function! s:init_vaxe_keymap()
	" .hxmlファイルを開いてくれるやつ
	nnoremap <buffer> ,vo :<C-u>call vaxe#OpenHxml()<CR>
	" タグファイル作ってくれるやつ(別途、.ctagsの定義をしませう)
	nnoremap <buffer> ,vc :<C-u>call vaxe#Ctags()<CR>
	" 自動インポートな
	nnoremap <buffer> ,vi :<C-u>call vaxe#ImportClass()<CR>
endfunction
autocmd MyAutoCmd FileType haxe call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType hxml call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType nmml.xml call s:init_vaxe_keymap()
" 以下はNeocomplete用
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'

" ActionScript Syntax
au BufNewFile,BufRead *.as set tags+=$HOME/actionscript.tags
au BufNewFile,BufRead *.as set ft=actionscript

if has('multi_byte_ime') || has('xim') 
	highlight Cursor guifg=NONE guibg=White
	highlight CursorIM guifg=NONE guibg=DarkRed
endif
