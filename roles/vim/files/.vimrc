" 文字コードをUFT-8に設定
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

" タブ・インデント周りの設定
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent

" 文字列検索
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 移動系
set showmatch
source $VIMRUNTIME/macros/matchit.vim " ノーマルモード時に「%」で対応するカッコにジャンプ

" コマンド補完
set wildmenu
set history=5000

" ペースト設定（クリップボード貼り付けの自動インデント設定）
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" バックアップファイルを作らない
set nobackup
set noswapfile " スワップファイルを作らない
set hidden " バッファが編集中でもその他のファイルを開けるように
set showcmd " 入力中のコマンドをステータスに表示する
set backspace=indent,eol,start


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 見た目系
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 行番号を表示
set number
" 行番号の色を指定
autocmd ColorScheme * highlight LineNr ctermfg=100
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ビープ音を可視化
set visualbell
" ステータスラインを常に表示
set laststatus=2
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" カラースキーム
syntax on
colorscheme hybrid
set background=dark
let g:hybrid_use_iTerm_colors = 1

vnoremap > >gv
vnoremap < <gv
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle 設定
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする・・・・・・①
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する・・・・・・②
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'scrooloose/syntastic'


" コードの自動補完プラグイン
if has('lua')
 NeoBundle 'Shougo/neocomplete.vim'
 NeoBundle "Shougo/neosnippet"
 NeoBundle 'Shougo/neosnippet-snippets'
endif
"----------------------------------------------------------
call neobundle#end()

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on
" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck



"----------------------------------------------------------
" Syntasticの設定
"----------------------------------------------------------
" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時に構文エラーチェックを実行しない
let g:syntastic_check_on_open = 0
" 「:wq」で終了する時も構文エラーチェックする
let g:syntastic_check_on_wq = 1
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
  " Vim起動時にneocompleteを有効にする
  let g:neocomplete#enable_at_startup = 1
  " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
  let g:neocomplete#enable_smart_case = 1
  " 3文字以上の単語に対して補完を有効にする
  let g:neocomplete#min_keyword_length = 3
  " 区切り文字まで補完する
  let g:neocomplete#enable_auto_delimiter = 1
  " 1文字目の入力から補完のポップアップを表示
  let g:neocomplete#auto_completion_start_length = 1
