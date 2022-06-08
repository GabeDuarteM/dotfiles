local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_compiled_path = fn.stdpath('config') .. '/lua/packer_compiled.lua'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

local function getConfig(name)
  pcall(require, "plugins/configs/" .. name)
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
  display = {
    open_fn = function()
      return util.float({ border = 'single' })
    end
  }
})

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-sensible'
  use { 'tpope/vim-unimpaired', opt = true, keys = { { "n", "[" }, { "n", "]" } } }
  use { 'tpope/vim-fugitive', opt = true, cmd = { 'G', 'Git' } }
  use { 'tpope/vim-rhubarb', opt = true, cmd = { 'GBrowse' } } -- companion to fugitive, allows to open github specific urls and stuff
  -- use { 'tpope/vim-commentary', opt = true, keys = { { "n", 'gc' }, { "v", 'gc' } } }
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth' -- adjusts identation
  -- use 'tpope/vim-obsession'
  -- use 'tpope/vim-eunuch'
  use { 'tpope/vim-abolish', opt = true, keys = { { 'n', 'crs' }, { 'n', 'crm' }, { 'n', 'crc' }, { 'n', 'cru' }, { 'n', 'crs' }, { 'n', 'cr.' }, { 'n', 'cr<space>' }, { 'n', 'crt' } } }

  use 'shumphrey/fugitive-gitlab.vim'

  use { 'neovim/nvim-lspconfig', config = getConfig('lspconfig') }

  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } }, config = getConfig('telescope'), }

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', requires = { { 'nvim-telescope/telescope.nvim' } } }

  use {
    'sudormrfbin/cheatsheet.nvim',
    config = getConfig('cheatsheetnvim'),
    opt = true,
    cmd = { 'Cheatsheet', 'CheatsheetEdit' },
    keys = { '<leader>?' },
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  use { 'rmagatti/auto-session' }

  use {
    'rmagatti/session-lens',
    requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = getConfig('session-lens')
  }

  use { 'jose-elias-alvarez/null-ls.nvim', requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } }

  use { 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = { 'jose-elias-alvarez/null-ls.nvim' } }
  use { 'onsails/lspkind-nvim', config = getConfig('lspkind') }

  use { 'ThePrimeagen/harpoon', requires = { 'nvim-lua/plenary.nvim' }, config = getConfig('harpoon') }

  use 'kyazdani42/nvim-web-devicons'
  use { 'kyazdani42/nvim-tree.lua', config = getConfig('nvim-tree'), requires = { 'kyazdani42/nvim-web-devicons' } }

  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }, config = getConfig('lualine') }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use { 'hrsh7th/nvim-cmp', config = getConfig('nvim-cmp') }
  use { "ray-x/lsp_signature.nvim", config = getConfig('lsp_signature') }
  use 'hrsh7th/cmp-vsnip'
  use { 'hrsh7th/vim-vsnip', config = getConfig('vsnip') }
  use { 'hrsh7th/cmp-path', config = getConfig('cmp-path') }

  use { 'dyng/ctrlsf.vim', opt = true, cmd = { 'CtrlSF' } }
  use { 'nelstrom/vim-visual-star-search', opt = true, keys = { '*', '<leader>*' } }
  use 'wellle/targets.vim'
  use { 'machakann/vim-sandwich' }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app & yarn install', opt = true, ft = { 'markdown' } }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = getConfig('treesitter') }

  -- use { 'jiangmiao/auto-pairs' }
  use { 'windwp/nvim-autopairs', config = getConfig('autopairs') }
  use { 'lukas-reineke/indent-blankline.nvim', config = getConfig('blankline') }
  -- " use 'kamykn/spelunker.vim'
  use { 'AndrewRadev/linediff.vim', opt = true, cmd = { 'Linediff' } }
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons", config = getConfig('trouble') }
  use { 'folke/lsp-colors.nvim', config = getConfig('lsp-colors') }
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp', config = getConfig('cmp-tabnine') }

  -- " theme
  use 'morhetz/gruvbox'
  use 'joshdick/onedark.vim'
  use 'drewtempelmeyer/palenight.vim'
  use 'challenger-deep-theme/vim'
  use { 'folke/tokyonight.nvim', config = getConfig("tokyonight") }
  use { 'windwp/nvim-spectre', requires = 'nvim-lua/plenary.nvim', config = getConfig('spectre') }
  use {
    "lewis6991/gitsigns.nvim",
    -- event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = getConfig('gitsigns')
  }
  use { 'folke/lua-dev.nvim', config = getConfig('lua-dev') }
  use 'nathom/filetype.nvim'
  use {
    "karb94/neoscroll.nvim",
    -- keys = { "<C-u>", "<C-d>", "gg", "G" },
    config = getConfig('neoscroll'),
  }
  use { 'nvim-telescope/telescope-project.nvim', }
  use { "tweekmonster/startuptime.vim", cmd = "StartupTime" }
  use {
    "RRethy/vim-illuminate",
    event = "CursorHold",
    config = getConfig('illuminate')
  }
  use 'lewis6991/impatient.nvim'
  use { 'github/copilot.vim', config = getConfig('copilot') }
  use { 'TimUntersberger/neogit', config = getConfig('neogit'), opt = true, cmd = "Neogit" }
  use { 'akinsho/bufferline.nvim', config = getConfig('bufferline') }
  -- use { 'kdheepak/lazygit.nvim', config = getConfig('lazygit') }
  use { 'ggandor/lightspeed.nvim', config = getConfig('lightspeed') }
  use { 'ojroques/vim-oscyank', config = getConfig('oscyank') }
  use { "ThePrimeagen/refactoring.nvim", config = getConfig('refactoring'), requires = { { "nvim-lua/plenary.nvim" }, { "nvim-treesitter/nvim-treesitter" } } }

  use { "numToStr/Comment.nvim", config = getConfig('comment') }

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
