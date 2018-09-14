colorscheme sakura

" クリップボード関連
if has("x11")
  "nnoremap <C-V> "+P
  inoremap <C-v> <C-o>"+P
  vnoremap y "+y
else
  nnoremap <C-v> "*p
  inoremap <C-v> "*p
  vnoremap y "*y
endif

" 変更があったファイルを自動で読み込む
set autoread
