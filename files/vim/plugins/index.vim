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
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-rooter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Valloric/MatchTagAlways'
Plug 'wakatime/vim-wakatime'
Plug 'raimondi/delimitmate'
Plug 'ryanoasis/vim-devicons'
Plug 'semanser/vim-outdated-plugins'
Plug 'SirVer/ultisnips'
Plug 'farmergreg/vim-lastplace'
Plug 'godlygeek/tabular'
Plug 'wincent/vcs-jump'
Plug 'kamykn/spelunker.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'justinmk/vim-sneak'
Plug 'metakirby5/codi.vim'

" syntax
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'sheerun/vim-polyglot'

" theme
Plug 'joshdick/onedark.vim'

call plug#end()

" source all configs inside the plugins folder, 
" except this current file
let files = split(glob($DOTFILES_FOLDER.'/files/vim/plugins/*', '\n'))
let thisFileIndex = index(files, $DOTFILES_FOLDER.'/files/vim/plugins/index.vim')
call remove(files, thisFileIndex)

for f in files
    exe 'source' f
endfor

