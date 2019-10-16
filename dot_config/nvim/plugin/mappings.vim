" disable the space functionality, so it doesn't interfere when it is the leader
nnoremap <SPACE> <Nop>
vnoremap <SPACE> <Nop>

" Make copy and paste use the clipboard, instead of the register
vnoremap <leader>y  "+y
vnoremap <leader>Y  "+yg$
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap <leader>dd "+dd
vnoremap <leader>d "+d

" Move splitted windows
nnoremap <C-S-J> <C-W><C-S-J>
nnoremap <C-S-K> <C-W><C-S-K>
nnoremap <C-S-L> <C-W><C-S-L>
nnoremap <C-S-H> <C-W><C-S-H>

" Switch between split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize -10<CR>
nnoremap <Right> :vertical resize +10<CR>

" Goes to the start of the line
noremap H ^
" Goes to the end of the line
noremap L $
" Goes file lines above
noremap J 5j
" Goes file lines below
noremap K 5k

" Find and replace
nnoremap <leader>h :%s///gc<left><left><left><left>
vnoremap <leader>h :s///gc<left><left><left><left>

" Clear highlighted search terms while preserving history
nmap <silent> <leader>/ :nohlsearch<CR>

" prevent entering ex mode accidentally
nnoremap Q <Nop>

" Source (reload) vimrc.
nnoremap <leader>so :source $MYVIMRC<cr>

" Reselect the last yanked text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" print the syntax highlighting under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Select all lines of the file (ctrl-a equivalent)
nnoremap vA ggVG

" Closes all buffers, but the current one
command! BufOnly execute "%bd|e#|bd#"
