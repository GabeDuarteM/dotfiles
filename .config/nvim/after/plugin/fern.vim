" nnoremap <silent> <leader>n :Fern . -reveal=% -drawer -toggle<CR>
" nnoremap <silent> <leader><leader>n :Fern %:h -reveal=% -drawer -toggle<CR>

let g:fern#renderer = "devicons"
let g:fern#default_hidden = 1
let g:fern#default_exclude = "^\\%(\\.git.*\\|node_modules\\)$"
let g:fern#drawer_width = 70
