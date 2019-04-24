" Automatically set goyo
function! s:auto_goyo()
  let filetypes = [
        \ 'markdown',
        \ 'text'
        \ ]

  if index(filetypes, &ft) >= 0
    Goyo 80
  elseif exists('#goyo')
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction
augroup goyo_markdown
  autocmd!
  autocmd BufNewFile,BufRead * call s:auto_goyo()
augroup END

