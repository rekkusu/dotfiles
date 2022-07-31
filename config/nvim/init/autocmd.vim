augroup filereadcmd
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd BufNewFile * setlocal fileencoding=utf-8
  autocmd BufNewFile,BufRead *.jsy setlocal filetype=yacc
  autocmd BufNewFile,BufRead *.ejs setlocal filetype=html
  autocmd BufNewFile,BufRead *.json setlocal filetype=json
  autocmd BufNewFile,BufRead *.twig setlocal filetype=htmldjango
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.scala setf scala
  autocmd BufRead,BufNewFile *.sage setfiletype python

  autocmd BufNewFile,BufRead *.go setlocal filetype=go
  autocmd BufNewFile,BufRead *.kt setlocal filetype=kotlin

augroup END
