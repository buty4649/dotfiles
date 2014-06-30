set nocompatible

" ---------------------------------------------------------
"  前処理
" ---------------------------------------------------------
"  Windowsの場合のみ.vimに変更
if has('win32')
	 set runtimepath^=$HOME/.vim
endif

" NeoBundleの初期化
let g:neobundle#types#git#default_protocol = 'https'
if has('vim_starting')
	 set runtimepath+=$HOME/.vim/bundle/neobundle.vim
endif
filetype plugin indent off

call neobundle#rc()

" プラグインの定義 ------------------------------------------------------------
NeoBundle 'altercation/vim-colors-solarized.git'
"NeoBundle 'basyura/mduem.vim'
NeoBundle 'banyan/Nonopaste.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'itchyny/thumbnail.vim'
NeoBundle 'jtratner/vim-flavored-markdown.git'
NeoBundle 'glidenote/memolist.vim'
"NeoBundle 'kien/ctrlp.vim.git'
NeoBundle 'LeafCage/unite-recording'
NeoBundle 'motemen/git-vim.git'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mru.vim'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'superbrothers/vim-quickrun-markdown-gfm'
NeoBundle 'thinca/vim-fontzoom'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'Lokaltog/vim-powerline.git'
"NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-jp/vimdoc-ja'
"NeoBundle 'vimwiki'

" 非同期通信を可能にする
" 'build'が指定されているのでインストール時に自動的に
" 指定されたコマンドが実行され vimproc がコンパイルされる
"NeoBundle "Shougo/vimproc", {
"	 \ "build": {
"	 \   "windows"   : "make -f make_mingw32.mak",
"	 \   "cygwin"    : "make -f make_cygwin.mak",
"	 \   "mac"       : "make -f make_mac.mak",
"	 \   "unix"      : "make -f make_unix.mak",
"	 \ }}


" +clientserverの時だけロード
if has('clientserver')
    NeoBundle 'thinca/vim-singleton'
    " 多重起動チェック
    call singleton#enable()

endif

filetype plugin indent on

" プラグインのインストールチェック
if neobundle#exists_not_installed_bundles()
	 echomsg 'Not installed bundles : ' .
			\ string(neobundle#get_not_installed_bundle_names())
	 echomsg 'Please execute ":NeoBundleInstall" command.'
endif


" ---------------------------------------------------------
"  基本設定
" ---------------------------------------------------------
"  デフォルト文字コードはUTF-8
set enc=utf-8
set termencoding=utf-8

" see also: http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
" 検索関連 ------------------------------------------------------------------
set ignorecase       " 大文字小文字を区別しない
set smartcase        " 検索文字に大文字がある場合は大文字小文字を区別しない
set incsearch        " インクリメンタルサーチ
set hlsearch         " 検索結果をハイライト

" 編集関連 ------------------------------------------------------------------
set shiftround          " インデントをshiftwidthで丸める
set infercase           " 補完時に大文字小文字を区別しない
"set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set modeline            " モードラインを有効化

" Tabの設定
set tabstop=3
set shiftwidth=4
set softtabstop=0
set expandtab

" 折り返しをしない
set textwidth=0
autocmd FileType text setlocal textwidth=0

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" ヤンクでクリップボードにコピー
"set clipboard=unnamed

" スワップ・バックアップファイルを無効化
set noswapfile
set nobackup
set nowritebackup

" 表示関連 ------------------------------------------------------------------
set number              " 行番号を表示
set showtabline=2       " タブラインを常時表示
set cursorline          " カーソル行をハイライト
set wrap                " 折り返し表示
set textwidth=0         " 自動改行の禁止
set colorcolumn=80      " 80文字目に線を入れる
set splitright          " 垂直分割を右側にする

" 特殊文字を可視化
set list
set listchars=tab:»\ ,eol:↲,extends:»,precedes:«,nbsp:%

" 再描画を抑止
set lazyredraw

" カラースキームの設定
syntax enable
set background=dark
colorscheme solarized
"colorscheme sakura

" undoファイル置き場を変更
set undodir=~/.vim/undo

" Windowsのみテンポラリを変更する
if has('win32') || has('win64')
  "環境変数$TMPを使用する場合
  set directory=$TMP
  set backupdir=$TMP
endif

" ---------------------------------------------------------
"  キーマップ設定
" ---------------------------------------------------------
" Leaderを,に設定
let mapleader=","

" カーソル移動
nnoremap j gj
nnoremap k gk
nnoremap <C-d> 10gj
nnoremap <C-u> 10gk

" ウインドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 新規タブ作成
nnoremap <silent> <S-t> :tabnew<CR>

" 検索時に\vを追加
nnoremap / /\v
vnoremap / /\v

" 検索時のハイライトを無効化
nnoremap <silent> <Leader><Space> :noh<CR>
nnoremap <silent> <ESC><ESC> :noh<CR>

" ; を :にマッピング
nnoremap ; :

" バッファ選択
nnoremap b <ESC>:ls<CR>b

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" 折りたたみ(HTMLタグ)
nnoremap <Leader>zt vatzf
" 折りたたみ(カッコ)
nnoremap <Leader>z( va(zf
nnoremap <Leader>z{ va{zf
nnoremap <Leader>z[ va[zf

" カーソル下の単語を * で検索
nmap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" バッファ選択
nnoremap b <ESC>:ls<CR>:b

" インサートモード: Ctrl+Vを貼付けにする
imap <C-v> <MiddleMouse>

" インサートモード: Ctrl+cをESCキーと同等にする
imap <C-c> <ESC>

" F1キーを無効化
nmap <F1> <nop>
imap <F1> <nop>

" F3で検索履歴を開く
nnoremap <F3> <CR>q/

" q:,q/,q?は無効化
nnoremap q: <nop>
nnoremap q/ <nop>
nnoremap q? <nop>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" .vimrc, .gvimrcの再読み込み
nnoremap <Leader>. :source ~/.vimrc<cr>:source ~/.gvimrc<cr>

" Fontzoom!(フォントの大きさを元に戻す)
nnoremap <silent> <C-@> :Fontzoom!<cr>

" インサートモードの設定
inoremap <C-a> <C-o>0
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-e> <C-o>$

inoremap <C-h> <BS>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-f> <Right>

inoremap <C-w> <C-o>W

"inoremap { {}<Left>
"inoremap [ []<Left>
"inoremap ( ()<Left>
"inoremap " ""<Left>
"inoremap ' ''<Left>
"inoremap < <><Left>


" Visualモードのヤンクはクリップボードコピーにする
vnoremap y "*y

" -- -- snip -- --
vmap <silent> <C-s> s-- -- snip -- --<ESC>0


" コマンドモードの設定
" Bash風のキーバインドにする
cnoremap <C-a> <C-f>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-f> <Right>
cnoremap <C-h> <BackSpace>
cnoremap <C-p> <ESC>q:

" 日付入力
noremap  <silent> <F5> <ESC>a<F5>
inoremap <silent> <F5> <C-r>=strftime("%Y/%m/%d %H:%M:%S")<CR>

" Unite呼び出し
nnoremap [unite]  <Nop>
nmap     <Space>u [unite]
nnoremap [unite]u <Esc>:Unite<Space>
nnoremap <silent> [unite]r <Esc>:Unite recording<CR>

" QuickRun呼び出し
nnoremap [quickrun]  <Nop>
nmap     <Space>q [quickrun]
nnoremap [quickrun]q <Esc>:QuickRun<CR>

" Gist呼び出し
nnoremap [Gist]   <Nop>
nmap     <Space>g [Gist]
nnoremap [Gist]g  <Esc>:GistUpload<CR>
nnoremap [Gist]b  <Esc>:Gist -b<CR>

" memolist系
map <Leader>mn :MemoNew<CR>
map <Leader>ml :MemoList<CR>
map <Leader>mg :MemoGrep<CR>

" ---------------------------------------------------------
"  自動コマンド設定
" ---------------------------------------------------------
"  リサイズ時に分割ウインドウを調整する
autocmd VimResized * :wincmd =

" markdown シンタックスを内部的にGFMへ変更する
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" ---------------------------------------------------------
"  プラグインの設定
" ---------------------------------------------------------
" neocomplcacheを有効化する
let g:neocomplcache_enable_at_startup = 1

" lightlineの設定(GUIのみ)
if has('gui_running')
    let g:lightline = {
        \ 'colorscheme' : 'wombat',
        \ 'active'      : {
        \   'left'      : [
        \                  ['mode', 'paste'],
        \                  ['readonly', 'absolutepath', 'modified']
        \                 ]
        \  },
        \ 'inactive'    : {
        \   'left'      : [ ['readonly', 'absolutepath', 'modified'] ]
        \  },
        \ }
endif
"       \ 'separator'   : { 'left': '⮀', 'right': '⮂' },
"       \ 'subseparator': { 'left': '⮁', 'right': '⮃' },


" vim-quickrunの設定
let g:quickrun_config = {
\   'markdown': {
\     'type': 'markdown/gfm',
\     'outputter': 'browser'
\   }
\ }
"if has('win32') || has('win64')
"    let g:quickrun_config.ghmarkdown = {
"        \ 'outputter' : 'null',
"        \ 'command'   : 'cygstart',
"        \ 'exec'      : '%c %s',
"        \ }
"endif

" memolistの設定
let g:memolist_path = ""
let g:memolist_memo_suffix = "md"




" ---------------------------------------------------------
"  ローカルコマンドの定義
" ---------------------------------------------------------
" Syntax表示コマンド
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction

function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction

function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction

command! SyntaxInfo call s:get_syn_info()


" Gistするときにft=""なら強制的にmarkdownにする
function! s:gist_upload()
  if &ft == ""
    setfiletype markdown
  endif
  :Gist
endfunction
command! GistUpload call s:gist_upload()

" ---------------------------------------------------------
"  環境依存ファイルの読み込み
" ---------------------------------------------------------
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" vim:ft=vim:et
