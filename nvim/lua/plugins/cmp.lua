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
      'petertriho/cmp-git',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      require('luasnip.loaders.from_vscode').lazy_load()

      local lspkind = require('lspkind')
      lspkind.init({
      })

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end

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
          ['<C-e>'] = cmp_action.toggle_completion(),
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp_action.luasnip_supertab()
            else
              fallback()
            end
          end),
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
          { name = 'nvim_lsp'},
          { name = 'luasnip' },
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
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
