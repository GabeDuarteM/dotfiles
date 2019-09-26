" Show hidden files/directories
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.swp$', '\.DS_Store', '\.git\/']

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Quit NERDTree after opening a file
let g:NERDTreeQuitOnOpen = 1

" Automatically delete the buffer of the file you just deleted with NerdTree
let g:NERDTreeAutoDeleteBuffer = 1

" Disable the help menu
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1

let g:NERDTreeMapJumpLastChild = ''
let g:NERDTreeMapJumpFirstChild = ''

let g:NERDTreeWinSize=60

let g:NERDTreeMapQuit='gq'

"  Toggle NERDTree on/off
nnoremap <leader><leader>n :NERDTreeToggle<CR>

function! ToggleNERDTreeFind()
    if g:NERDTree.IsOpen()
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
endfunction

"  Opens current file location in NERDTree
nnoremap <silent> <leader>n :call ToggleNERDTreeFind()<CR>
