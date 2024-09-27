return {
  { 'lewis6991/gitsigns.nvim', config = true, event = 'BufReadPre' },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  { 'tpope/vim-rhubarb', event = 'VeryLazy', dependencies = 'vim-fugitive' },
}
