let g:ctrlsf_ackprg = 'rg'

let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }

let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ }

nnoremap <leader>g :CtrlSF<space>
nnoremap <leader>j :CtrlSF<space><C-R><C-W>

