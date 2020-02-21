colorscheme sakura

" クリップボード関連
if has("x11")
  noremap  <S-Insert> "+gp
  inoremap <S-Insert> <C-o>"+gP
  inoremap <C-v> <C-o>"+gP
  vnoremap y "+y
else
  nnoremap <C-v> "*p
  inoremap <C-v> "*p
  vnoremap y "*y
endif

" 変更があったファイルを自動で読み込む
set autoread
