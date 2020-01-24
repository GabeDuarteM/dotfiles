if exists("g:loaded_edit_spellfile")
    finish
endif
let g:loaded_edit_spellfile = 1

function! LocalEditSpellfile()
    vsp $CHEZMOI_FOLDER/dot_config/nvim/spell/en.utf-8.add
endfunction

command! EditSpellfile call LocalEditSpellfile()

