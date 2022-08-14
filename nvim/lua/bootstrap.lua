local PKGS = {
  'savq/paq-nvim';
  'rebelot/kanagawa.nvim';
  {'nvim-treesitter/nvim-treesitter', run=function ()
    vim.cmd('TSUpdate')
  end};
  'wincent/ferret';
  'tpope/vim-repeat';
  'tpope/vim-surround';
  'tpope/vim-fugitive';
  'tpope/vim-rails';
  'kyazdani42/nvim-web-devicons';
  'kyazdani42/nvim-tree.lua';
  'numToStr/Comment.nvim';
  {'junegunn/fzf', run='./install --bin'};
  'ibhagwan/fzf-lua';
  'lewis6991/gitsigns.nvim';
  'windwp/nvim-autopairs';
  'VonHeikemen/lsp-zero.nvim';
  'neovim/nvim-lspconfig';
  'williamboman/mason.nvim';
  'williamboman/mason-lspconfig.nvim';

  -- Autocompletion
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'saadparwaiz1/cmp_luasnip';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-nvim-lua';
  'hrsh7th/cmp-cmdline';

  -- Snippets
  'L3MON4D3/LuaSnip';
  'rafamadriz/friendly-snippets';

  'RRethy/nvim-treesitter-endwise';

  'lukas-reineke/indent-blankline.nvim';
  'ojroques/vim-oscyank';

  'github/copilot.vim';

  'gbprod/yanky.nvim';

  'feline-nvim/feline.nvim';
}

local function paq_path()
  return vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
end
local function paq_missing()
  return vim.fn.empty(vim.fn.glob(paq_path())) > 0
end

local function clone_paq()
  if paq_missing() then
    vim.fn.system {
      'git',
      'clone',
      '--depth=1',
      'https://github.com/savq/paq-nvim.git',
      paq_path()
    }
  end
end

local function bootstrap_paq()
  clone_paq()

  -- Load Paq
  vim.cmd('packadd paq-nvim')
  local paq = require('paq')

  -- Exit nvim after installing plugins
  vim.cmd('autocmd User PaqDoneInstall quit')

  -- Read and install packages
  paq(PKGS)
  paq.install()
end

local function setup()
  if paq_missing() then
    print("paq not found, bootstrapping, ignore errors with 'q'")
    bootstrap_paq()
  end
  vim.cmd('packadd paq-nvim')
  local paq = require('paq')
  paq(PKGS)
end

return { bootstrap_paq = bootstrap_paq, setup = setup }
