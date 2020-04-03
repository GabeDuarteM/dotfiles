nmap ; :Buffer<CR>
nmap <leader>t :Files<CR>
nnoremap <leader><leader>j :Lines <C-R><C-W><CR>

command! -bang -nargs=* FindAll call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --no-ignore --hidden --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

