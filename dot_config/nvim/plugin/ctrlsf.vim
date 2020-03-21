let g:ctrlsf_ackprg = 'rg'

let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }

let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ "quit": "gq",
    \ }

let g:ctrlsf_extra_backend_args = {
    \ 'rg': '--hidden --glob "!.git/*"'
    \ }
let g:ctrlsf_populate_qflist = 1

nnoremap <leader>f :CtrlSF<space>
nnoremap <leader><leader>f :CtrlSF<space><C-R><C-W>
vmap <leader><leader>f <Plug>CtrlSFVwordPath
command! CSFT execute ":CtrlSFToggle"
