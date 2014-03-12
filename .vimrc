"
"    ██░ ██   ▄████   ██████  ██ ▄█▀
"   ▓██░ ██▒ ██▒ ▀█▒▒██    ▒  ██▄█▒ 
"   ▒██▀▀██░▒██░▄▄▄░░ ▓██▄   ▓███▄░ 
"   ░▓█ ░██ ░▓█  ██▓  ▒   ██▒▓██ █▄ 
"   ░▓█▒░██▓░▒▓███▀▒▒██████▒▒▒██▒ █▄
"    ▒ ░░▒░▒ ░▒   ▒ ▒ ▒▓▒ ▒ ░▒ ▒▒ ▓▒
"    ▒ ░▒░ ░  ░   ░ ░ ░▒  ░ ░░ ░▒ ▒░
"    ░  ░░ ░░ ░   ░ ░  ░  ░  ░ ░░ ░ 
"    ░  ░  ░      ░       ░  ░  ░   
"
" 後方非互換
set nocompatible
" 行番号
set number
" 自動インデント
set autoindent
" 保存時の文字コード
set fileencoding=utf-8
" 編集時の文字コード
set encoding=utf8
" 想定するファイルフォーマット
set fileformats=unix,dos
" 標準のファイルフォーマット
set fileformat=unix
" 特殊文字の可視化
set list
" TAB
set listchars=tab:›·
" 行末の空白
set listchars+=trail:-
" 行末
set listchars+=eol:†
" NBSP
set listchars+=nbsp:·
" 折り返し
set listchars+=extends:❯
set listchars+=precedes:❮

" タブ表示文字数
set tabstop=4
" タブ表示文字数
set shiftwidth=4

" タブをスペースに変換
if hostname()=="mbp.local"
	set expandtab
endif

" ステータスラインを全てのウィンドウに表示
set laststatus=2
set statusline=%<%F\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" コマンドをステータスラインに表示
set showcmd
" マッチングを表示
set showmatch
" マッチングにジャンプ
set matchtime=3
" 検索結果をハイライト
set hlsearch
" 検索時に小文字を優先
set smartcase
set ignorecase
" 上から再検索
set wrapscan
" 保存せずにバッファ切り替え
set hidden

" PHP用辞書
au BufNewFile,BufRead *.php set dictionary=~/.vim/dict/php.dict

" NeoBundle
if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle "itchyny/lightline.vim"
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'surround.vim'
NeoBundle 'jdonaldson/vaxe'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'osyo-manga/vim-precious'
NeoBundle 'majutsushi/tagbar'

" ファイルに応じてインデント方式を変える
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
" Sudo write
command Suw w !sudo tee > /dev/null %

" neocomplete
" if_luaが有効ならneocompleteを使う
NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'

if neobundle#is_installed('neocomplete')
    " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'
	let g:neocomplete#sources#syntax#min_keyword_length = 1
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
	let g:neocomplete#sources={'_': ['vim','omni','file/include']}
	" AutoComplPop like behavior.
	" let g:neocomplete#enable_auto_select = 1
	" inoremap <expr><C-g>	neocomplete#undo_completion()
	" inoremap <expr><C-l>	neocomplete#complete_common_string()
	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
	" Haxe
	let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'
	" 改行で補完候補を非表示
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function s:my_cr_function()
		return neocomplete#close_popup() . "\<CR>"
	endfunction
	" BSで補完候補を非表示
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	" inoremap <expr><C-y>  neocomplete#close_popup()
	" inoremap <expr><C-e>  neocomplete#cancel_popup()

elseif neobundle#is_installed('neocomplcache')
    " neocomplcache用設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
endif

" Tabで補完
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" 補完時にPreviewウィンドウを表示しない
set completeopt=menuone

" オムニ補完を設定
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" phpcomplete
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables = 1

" viminfo
set viminfo='100,<50,s10,h,%

" backup 
set backup
set backupdir=$HOME/.vim/backup
let $directory = $bacupdir

" grep時に|cw
autocmd QuickFixCmdPost *grep* cwindow

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


" ActionScript Syntax
au BufNewFile,BufRead *.as set tags+=$HOME/actionscript.tags
au BufNewFile,BufRead *.as set ft=actionscript

if has('multi_byte_ime') || has('xim')
	highlight Cursor guifg=NONE guibg=White
	highlight CursorIM guifg=NONE guibg=DarkRed
endif

" colorscheme
syntax on
set background=dark
colorscheme solarized
highlight NonText ctermfg=green
highlight SpecialKey ctermfg=green
"your other plugins
NeoBundleCheck

highlight Pmenu ctermbg=magenta ctermfg=white
highlight PmenuSel ctermbg=white ctermfg=magenta
highlight PmenuSBar ctermbg=magenta ctermfg=white
