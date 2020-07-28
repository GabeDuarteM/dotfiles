if !exists('g:NERDTree') || exists("g:loaded_nerdtree_copy_root_path")
    finish
endif
let g:loaded_nerdtree_copy_root_path = 1

call NERDTreeAddMenuItem({
    \ 'text': 'copy c(u)rrent root path to clipboard',
    \ 'shortcut': 'u',
    \ 'callback': 'NERDTreeCopyRootPathMenuItem' })

function! NERDTreeCopyRootPathMenuItem()
    let rootPath = g:NERDTree.ForCurrentTab().getRoot().path.str()
    let fullPath = g:NERDTreeFileNode.GetSelected().path.str()
    let relativePath = substitute(fullPath, rootPath . "/", "", "")

    call setreg('+', relativePath)
endfunction

