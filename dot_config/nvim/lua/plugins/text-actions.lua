return {
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'numToStr/Comment.nvim', config = true, event = 'VeryLazy' },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    main = 'ibl',
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
    event = 'InsertEnter',
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function ()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require('ufo').setup({
        provider_selector = function (bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end
      })
    end,
    event = "BufReadPost",
    keys = {
      {'zR', function () require('ufo').openAllFolds() end, desc = "Open all folds"},
      {'zM', function () require('ufo').closeAllFolds() end, desc = "Close all folds"},
    },
  },
}
