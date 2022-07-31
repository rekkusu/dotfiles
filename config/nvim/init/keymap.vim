nnoremap <silent> tn :<C-u>tabedit<CR> :<C-u>tabnext<CR>
nnoremap <silent> td :<C-u>tabclose<CR>
nnoremap <silent> th :<C-u>tabprev<CR>
nnoremap <silent> tl :<C-u>tabnext<CR>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <silent> <ESC><ESC> :nohlsearch<CR><ESC>

vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k

tnoremap <Esc> <C-\><C-n>

imap <expr><silent><Tab> <SID>imap_tab()
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

function! s:imap_tab()
  if pumvisible()
    return "\<C-n>"
  else
    return "\<Tab>"
  endif
endfunction

nnoremap <silent> ss :sp<CR>:terminal<CR>
