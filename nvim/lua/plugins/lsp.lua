return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
  },
  {
    'nvimtools/none-ls.nvim',
    event = 'BufReadPre',
    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
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
  },
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')

      local lsp_attach = function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end

      lsp_zero.extend_lspconfig({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        lsp_attach = lsp_attach,
        float_border = 'rounded',
        sign_text = {
          error = '✘',
          warn = '▲',
          hint = '⚑',
          info = ''
        },
      })

      vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
          style = 'minimal',
          border = 'rounded',
          source = true,
          header = '',
          prefix = '',
        },
      })
      require('lspconfig').ruby_lsp.setup({
        mason = false,
      })
      require'lspconfig'.sorbet.setup{
        mason = false,
      }
      require'lspconfig'.ansiblels.setup{
        mason = false,
      }
      require('mason-lspconfig').setup({
        ensure_installed = {"lua_ls", "bashls", "yamlls", "jsonls"},
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          ["lua_ls"] = function()
            require('lspconfig').lua_ls.setup({
              on_init = function(client)
                require('lsp-zero').nvim_lua_settings(client, {})
              end
            })
          end,
          ["yamlls"] = function()
            require('lspconfig').yamlls.setup({
              settings = {
                yaml = {
                  schemas = {
                    ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.yml',
                  },
                },
              },
            })
          end
        }
      })
    end
  }
}
