local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_compiled_path = fn.stdpath('config')..'/lua/packer_compiled.lua'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function getConfig(name)
  pcall(require,"plugins/configs/" .. name)
end

-- Speed up loading of Lua modules. Note, this needs to happen BEFORE Lua
-- plugins are loaded.
-- Due to impatient, the packer_compiled file needs to be directly required.
pcall(require, 'packer_compiled')

local packer = require('packer')
local util = require('packer.util')

-- Initialize packer.nvim.
packer.init({
  compile_path = packer_compiled_path,
})

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-sensible'
    use {'tpope/vim-unimpaired', opt = true, keys = {{"n", "["}, {"n", "]"}}}
    use 'tpope/vim-fugitive'
    use {'tpope/vim-rhubarb', opt = true, cmd = {'GBrowse'}} -- companion to fugitive, allows to open github specific urls and stuff
    use {'tpope/vim-commentary', opt = true, keys = {{"n",'gc'}, {"v",'gc'}}}
    use 'tpope/vim-repeat'
    use 'tpope/vim-sleuth' -- adjusts identation
    -- use 'tpope/vim-obsession'
    -- use 'tpope/vim-eunuch'
    use {'tpope/vim-abolish', opt = true, keys = {{'n','crs'}, {'n','crm'}, {'n','crc'}, {'n','cru'}, {'n','crs'}, {'n','cr.'}, {'n','cr<space>'}, {'n','crt'}}}
    use { 'neovim/nvim-lspconfig', config = getConfig('lspconfig') }
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = getConfig('telescope'),
    }

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      requires = {{'nvim-telescope/telescope.nvim'}}
    }

    use { 
      'sudormrfbin/cheatsheet.nvim', 
      config = getConfig('cheatsheetnvim'), 
      opt = true,
      cmd = {'Cheatsheet', 'CheatsheetEdit'},
      keys = {'<leader>?'},
      requires = {
        {'nvim-telescope/telescope.nvim'},
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
      }
    }

    use { 'rmagatti/auto-session' }

    use {
      'rmagatti/session-lens',
      -- opt = true,
      -- keys = {{"n", "<leader>fs"}},
      requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
      config = getConfig('session-lens')
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
    }

    use {'jose-elias-alvarez/nvim-lsp-ts-utils', requires = {'jose-elias-alvarez/null-ls.nvim'}}
    use {'onsails/lspkind-nvim', config = getConfig('lspkind')}

    use {
      'ThePrimeagen/harpoon',
      -- opt = true,
      -- keys = {'<leader>hh','<leader>ha','<leader>h1','<leader>h2','<leader>h3','<leader>h4','<leader>h5','<leader>h6','<leader>h7','<leader>h8','<leader>h9'},
      requires = {'nvim-lua/plenary.nvim'},
      config = getConfig('harpoon')
    }

    use 'kyazdani42/nvim-web-devicons'
    use {
      'kyazdani42/nvim-tree.lua',
      config = getConfig('nvim-tree'),
      requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = getConfig('lualine')
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use { 'hrsh7th/nvim-cmp', config = getConfig('nvim-cmp') }
    -- For vsnip users.
    use 'hrsh7th/cmp-vsnip'
    use {'hrsh7th/vim-vsnip', config = getConfig('vsnip') }

    -- use { 'dhruvasagar/vim-prosession', requires = { { 'tpope/vim-obsession' } } }
              -- use 'nathanaelkane/vim-indent-guides'
    use {'dyng/ctrlsf.vim', opt = true, cmd = {'CtrlSF'} }
    use {'nelstrom/vim-visual-star-search', opt = true, keys = {'*'}}
    use 'wellle/targets.vim'
    use {'machakann/vim-sandwich'}
    use {'iamcco/markdown-preview.nvim', run = 'cd app & yarn install', opt = true, ft = {'markdown'} }
    -- use {
    --   'easymotion/vim-easymotion',
    --   config = getConfig('easymotion'),
    --   -- opt = true,
    --   -- keys = {{"n", "<leader>j"}, {"n", "<leader>k"},{"n", "<leader>s"}}
    -- }

    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = getConfig('treesitter') }

    -- Plug

    -- use 'itchyny/lightline.vim'
    -- use 'airblade/vim-rooter'
    -- " use 'Valloric/MatchTagAlways', { 'for': ['jsx', 'tsx'] }
    -- use 'wakatime/vim-wakatime'
    use 'jiangmiao/auto-pairs'
    -- use 'ryanoasis/vim-devicons'
    -- " use 'semanser/vim-outdated-plugins'
    -- " use 'SirVer/ultisnips'
    -- use 'farmergreg/vim-lastplace'
    -- " use 'kamykn/spelunker.vim'
    -- use 'justinmk/vim-sneak'
    -- " use 'roman/golden-ratio'
    use 'shumphrey/fugitive-gitlab.vim'
    -- use 'svermeulen/vim-cutlass'
    -- " use 'tpope/vim-vinegar'
    use 'AndrewRadev/linediff.vim'
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = getConfig('trouble'),
      opt = true,
      cmd = "Trouble"
    }
    use {'folke/lsp-colors.nvim', config = getConfig('lsp-colors')}
    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp', config = getConfig('cmp-tabnine')}
    -- " syntax
    -- " use 'leafgarland/typescript-vim'
    -- " use 'othree/yajs.vim'
    -- " use 'mxw/vim-jsx'
    -- use 'MaxMEllon/vim-jsx-pretty'
    -- use 'HerringtonDarkholme/yats.vim'
    -- " use 'ianks/vim-tsx'
    -- use 'pangloss/vim-javascript'
    -- use 'styled-components/vim-styled-components', { 'branch': 'main' }
    -- use 'jparise/vim-graphql'
    -- " use 'sheerun/vim-polyglot'
    -- " use 'posva/vim-vue'
    -- " use 'evanleck/vim-svelte', {'branch': 'main'}
    -- " let g:svelte_preprocessors = ['typescript']

    -- " theme
    use 'morhetz/gruvbox'
    use 'joshdick/onedark.vim'
    use 'drewtempelmeyer/palenight.vim'
    use 'challenger-deep-theme/vim'
    use {'folke/tokyonight.nvim', config = getConfig("tokyonight")}
    -- End Plug
    use {'windwp/nvim-spectre', requires = 'nvim-lua/plenary.nvim', config = getConfig('spectre')}
    -- use {'brooth/far.vim', config = getConfig("far")}
    use {
      "lewis6991/gitsigns.nvim",
      -- event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = getConfig('gitsigns')
    } 
    use 'folke/lua-dev.nvim'
    use 'nathom/filetype.nvim'
    use {
      "karb94/neoscroll.nvim",
      -- keys = { "<C-u>", "<C-d>", "gg", "G" },
      config = getConfig('neoscroll'),
    }
    use {'nvim-telescope/telescope-project.nvim', }
    use { "tweekmonster/startuptime.vim", cmd = "StartupTime" } 
    use {
      "RRethy/vim-illuminate",
      event = "CursorHold",
      config = getConfig('illuminate')
    }
    -- use { "camspiers/snap", rocks = { "fzy" }} 
    use 'lewis6991/impatient.nvim'
    use {'github/copilot.vim', config = getConfig('copilot'), disable = true}
    use {'TimUntersberger/neogit', config = getConfig('neogit'), opt = true, cmd = "Neogit"}
    use {'akinsho/bufferline.nvim', config = getConfig('bufferline')}
    -- use {'kdheepak/lazygit.nvim', config = getConfig('lazygit')}
    use {'ggandor/lightspeed.nvim', config = getConfig('lightspeed')}
    use {'ojroques/vim-oscyank', config = getConfig('oscyank')}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end 
)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerCompile
  augroup end
]])
