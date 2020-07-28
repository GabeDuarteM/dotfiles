let g:netrw_browse_split = 4
let g:netrw_winsize = 30

" ### Toggle window 
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vexplore
    endif
endfunction

" nnoremap <silent> <leader>n :call ToggleNetrw()<CR>

" ### Find in folder
function! NERDTreeFindInsideFolderEnabled()
    let path = g:NERDTreeFileNode.GetSelected().path

    return path.isDirectory 
endfunction

function! NERDTreeFindInsideFolderMenuItem()
    let rootPath = g:NERDTree.ForCurrentTab().getRoot().path.str()
    let fullPath = g:NERDTreeFileNode.GetSelected().path.str()
    let relativePath = substitute(fullPath, rootPath . "/", "", "")

    call feedkeys(":NERDTreeClose\<CR>")
    call feedkeys(":CtrlSF -G " . relativePath . "/** ")
endfunction

