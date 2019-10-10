" Install Coc servers
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-css',
  \ 'coc-highlight',
  \ 'coc-python',
  \ 'coc-ultisnips',
  \ 'coc-tabnine',
  \ 'coc-yank',
  \ 'coc-html',
  \ 'coc-git'
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Plug>delimitMateCR"

nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>di <Plug>(coc-implementation)
nmap <silent> <leader><TAB> <Plug>(coc-range-select)
xmap <silent> <leader><TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

" Mappings for function object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> <leader>i :call CocAction("doHover")<cr>
nnoremap <silent> <leader>I :call CocAction("showSignatureHelp")<cr>
nnoremap <silent> <leader>F :call CocAction("format")<cr>
vnoremap <silent> <leader>F :call CocAction("formatSelected")<cr>
nnoremap <silent> <leader>. :call CocAction("codeAction")<cr>
vnoremap <silent> <leader>. :call CocAction("codeAction")<cr>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" use tab and shift-tab to go back and forward on the snippets cursor
" locations
let g:coc_snippet_next = '<C-n>'
let g:coc_snippet_prev = '<C-P>'

augroup CocConfig
  autocmd!
  " coc-highlight: enable highlighting for symbol under cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Close preview window when completion is done.
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap <leader>gc <Plug>(coc-git-chunkinfo)

