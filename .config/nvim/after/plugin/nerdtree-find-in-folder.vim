if !exists('g:NERDTree') || exists("g:loaded_nerdtree_find_inside_folder")
    finish
endif

let g:loaded_nerdtree_find_inside_folder = 1

call NERDTreeAddMenuSeparator({
    \ 'isActiveCallback': 'NERDTreeFindInsideFolderEnabled'
    \ })

call NERDTreeAddMenuItem({
    \ 'text': '(f)ind inside this folder',
    \ 'shortcut': 'f',
    \ 'isActiveCallback': 'NERDTreeFindInsideFolderEnabled',
    \ 'callback': 'NERDTreeFindInsideFolderMenuItem' })

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
