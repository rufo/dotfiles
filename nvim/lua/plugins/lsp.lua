return {
  {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.nvim_workspace()
      lsp.setup()

      lsp.configure('yamlls', {
        settings = {
          yaml = {
            schemas = {
              ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.yml',
            },
          },
        },
      })
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
    event = 'BufReadPre',
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.erb_lint,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.formatting.eslint,
          null_ls.builtins.completion.spell,
        },
      })
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'folke/trouble.nvim',
    config = true,
    cmd = {
      'Trouble',
      'TroubleToggle',
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  }
}
