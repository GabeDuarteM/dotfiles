" Show hidden files/directories
let g:NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.swp$', '\.DS_Store', '\.git\/']

" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Quit Nerdtree after opening a file
let NERDTreeQuitOnOpen = 1

" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Disable the help menu
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"  Toggle NERDTree on/off
nmap <leader>n :NERDTreeToggle<CR>

"  Opens current file location in NERDTree
nmap <leader>f :NERDTreeFind<CR>
