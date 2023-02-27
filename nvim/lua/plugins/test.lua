return {
  {
    'vim-test/vim-test',
    keys = {
      { "<leader>t", "<cmd>TestNearest<CR>", desc = "Test nearest"},
      { "<leader>T", "<cmd>TestFile<CR>", desc = "Test nearest"},
      { "<leader>a", "<cmd>TestSuite<CR>", desc = "Test nearest"},
      { "<leader>l", "<cmd>TestLast<CR>", desc = "Test nearest"},
      { "<leader>g", "<cmd>TestVisit<CR>", desc = "Test nearest"},
    },
    config = function()
      vim.g['test#runners'] = {Ruby = {'GitHub'}}
      vim.g['test#strategy'] = 'neovim'
    end,
    dependencies = {
        'bswinnerton/vim-test-github',
      },
  },
  {
    'bswinnerton/vim-test-github',
    lazy = true,
  }
}
