" check whether vim-plug is installed and install it if necessary
let plugpath = $HOME."/.local/share/nvim/site/autoload/plug.vim"
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-signify'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'pangloss/vim-javascript'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-rooter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
Plug 'wakatime/vim-wakatime'

" syntax
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'sheerun/vim-polyglot'

" theme
Plug 'joshdick/onedark.vim'

call plug#end()

" configs
let files = split(glob($DOTFILES_FOLDER.'/files/vim/plugins/*', '\n'))
let thisFileIndex = index(files, $DOTFILES_FOLDER.'/files/vim/plugins/index.vim')

call remove(files, thisFileIndex)

for f in files
    exe 'source' f
endfor

"source $DOTFILES_FOLDER/files/vim/plugins/*
"source $DOTFILES_FOLDER/files/vim/plugins/nerdtree.vim
"source $DOTFILES_FOLDER/files/vim/plugins/denite.vim
"source $DOTFILES_FOLDER/files/vim/plugins/coc.vim
"source $DOTFILES_FOLDER/files/vim/plugins/goyo.vim
"source $DOTFILES_FOLDER/files/vim/plugins/vim-airline.vim
