augroup ReplacePunctuation
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> call s:replace_punctuation()
augroup END

function! s:replace_punctuation()
  let cursor = getpos('.')
  %s/。/．/ge
  %s/、/，/ge
  call setpos(".", cursor)
  unlet cursor
endfunction
