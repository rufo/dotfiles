return {
  {
    'hrsh7th/nvim-cmp',
    event = {
      'InsertEnter',
      'CmdlineEnter',
    },
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-cmdline',
      'zbirenbaum/copilot-cmp',
      'petertriho/cmp-git',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      require('luasnip.loaders.from_vscode').lazy_load()

      local lspkind = require('lspkind')
      lspkind.init({
        symbol_map = {
          Copilot = "",
        }
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg = "#6CC644"})

      cmp.setup({
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...',
            show_labelDetails = true,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<C-e>'] = cmp_action.toggle_completion(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'buffer' },
          { name = 'copilot' },
          { name = 'nvim_lsp'},
          { name = 'luasnip' },
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
          { name = 'buffer' },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
          },
        }),
      })
    end,
  },

  {
    'hrsh7th/cmp-nvim-lua',
    ft = 'lua',
    config = function()
      require('cmp').setup({
        sources = {
          { name = 'nvim_lua' },
        },
      })
    end,
  },
  {
    'petertriho/cmp-git',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = true,
    config = true,
  }
}
