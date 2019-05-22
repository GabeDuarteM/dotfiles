" Install Coc servers
" coc-tsserver coc-eslint coc-json coc-prettier coc-css
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-css',
  \ 'coc-highlight',
  \ 'coc-python',
  \ 'coc-ultisnips',
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
nmap <silent><leader>. <Plug>(coc-codeaction-selected)
xmap <silent><leader>. <Plug>(coc-codeaction-selected)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" use tab and shift-tab to go back and forward on the snippets cursor
" locations
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

augroup CocConfig
  autocmd!
  " coc-highlight: enable highlighting for symbol under cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Close preview window when completion is done.
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

