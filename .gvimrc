" ---------------------------------------------------------
"  GUI設定
" ---------------------------------------------------------
" メニューの文字化け対策
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_JP.utf-8
source $VIMRUNTIME/menu.vim

" カラースキーム設定
set t_Co=256
"set background=light
"colorscheme solarized
colorscheme sakura

" フォント設定
"set guifont=Ricty_Meiryo_for_Powerline:h10:cSHIFTJIS
set guifont=Osaka-Mono:h14

" ツールバーを非表示
set guioptions-=T

" カーソル行に下線を表示する
set cursorline

" タブのラベルにタブ番号を表示する＋ファイル名のみ表示
set guitablabel=%N:\ %{GuiTabLabel()}

" コマンド行を1行にする
set cmdheight=1

" 折り返しを無効化
set textwidth=0

set visualbell

" ハイライト設定(ToDo:後でカラースキームに追加)
"highlight CursorLine gui=underline guifg=NONE guibg=NONE guisp=NONE
"highlight SpecialKey guifg=LightGray
"highlight NonText guifg=Blue
"hi SpecialKey guifg=#d4eff2 guibg=bg


" ---------------------------------------------------------
"  コマンド設定
" ---------------------------------------------------------
" ドラッグ＆ドロップを新しいタブに開く
"autocmd VimEnter * tab all
"autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

" ウインドウの位置とサイズを記憶する
let g:save_window_file = expand('$HOME/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif


" cursolineをいい感じにする奴
" see. http://d.hatena.ne.jp/thinca/20090530/1243615055
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * call s:turnoff_cursorline()
  function! s:turnoff_cursorline()
      if &cursorline == 1
          setlocal nocursorline
      endif
  endfunction
  autocmd CursorHold,CursorHoldI * setlocal cursorline
augroup END

" ---------------------------------------------------------
"  キーマップ設定
" ---------------------------------------------------------
" タブ操作
nnoremap <silent> gf	:tabfirst<CR>
nnoremap <silent> gl	:tablast<CR>
nnoremap <silent> tt	:call <SID>TabNewLast()<CR>
nnoremap <silent> tT	:tabclose<CR>
nnoremap <silent> H		gT
nnoremap <silent> L		gt

" Powerlineを読み込み
NeoBundleSource vim-powerline

" ---------------------------------------------------------
"  関数の定義
" ---------------------------------------------------------
" 新しいタブを最後に開く
function! s:TabNewLast()
		let tabcount = tabpagenr('$')
		if (tabcount > 1)
				execute ":tablast"
		endif
		execute ":tabnew"
endfunction

" 個別のタブの表示設定をします
function! GuiTabLabel()
  " タブで表示する文字列の初期化をします
  let l:label = ''

  " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
  let l:bufnrlist = tabpagebuflist(v:lnum)

  " 表示文字列にバッファ名を追加します
  " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
  let l:label .= l:bufname == '' ? 'No title' : l:bufname

  " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
  let l:wincount = tabpagewinnr(v:lnum, '$')
  if l:wincount > 1
    let l:label .= '[' . l:wincount . ']'
  endif

  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor

  " 表示文字列を返します
  return l:label
endfunction


" vim: set ft=vim et
