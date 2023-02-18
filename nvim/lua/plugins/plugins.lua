return {
  {'nvim-lua/plenary.nvim',
    lazy = true,
  },
  { "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("lsp-zero").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = { separator = " ", highlight = true, depth_limit = 5 },
  },
  {'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPost",
    opts = {
      ensure_installed = {
        "ruby",
        "lua",
        "json",
        "dockerfile",
        "javascript",
        "typescript",
        "bash",
        "comment",
        "css",
        "go",
        "html",
        "python",
        "regex",
        "scss",
        "toml",
        "vim",
        "yaml",
        "tsx",
        "vue",
        "make",
        "c",
        "markdown",
        "markdown_inline",
        "help",
      },
      -- Install parsers synchronously when headless
      sync_install = #vim.api.nvim_list_uis() == 0,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      endwise = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {'RRethy/nvim-treesitter-endwise',},
  };
  {'wincent/ferret',
    cmd = {
      "Ack",
      "Lack",
      "Back",
      "Black",
      "Quack",
      "Acks",
      "Lacks",
      "Qargs",
      "Largs",
    }
  };
  {'tpope/vim-repeat',
    event = "VeryLazy",
  };
  {'tpope/vim-surround',
    event = "VeryLazy",
  };
  {'tpope/vim-fugitive',
    event = "VeryLazy",
  };
  {'tpope/vim-rails',
    event = "VeryLazy",
  };
  {'nvim-neo-tree/neo-tree.nvim',
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree").close_all()
          end
        }
      },
      window = {
        mappings = {
          ["o"] = "open"
        }
      }
    },
    branch = "v2.x",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>[", ":Neotree toggle=true<CR>", desc = "Neotree filesystem toggle" },
      { "<leader>]", ":Neotree filesystem reveal<CR>", desc = "Find file in NvimTree" },
    },
    event = "BufEnter"
  };
  {'numToStr/Comment.nvim',
    config = true,
    event = "VeryLazy",
  };
  {'junegunn/fzf',
    build = './install --bin',
    lazy = true,
  };
  {'ibhagwan/fzf-lua',
    dependencies = {
      "junegunn/fzf",
    },
    keys = {
      { "<leader>p", "<cmd>lua require('fzf-lua').files()<CR>", desc = "FZF Files" },
      { "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>", desc = "FZF Buffers" },
    }
  };
  {'lewis6991/gitsigns.nvim',
    config = true,
    event = "BufReadPre",
  };
  {'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
    event = "InsertEnter",
  };
  {'VonHeikemen/lsp-zero.nvim',
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
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.yml",
            }
          }
        }
      })
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip'
    },
    event = "BufReadPre"
  };
  {'jose-elias-alvarez/null-ls.nvim',
    event = "BufReadPre",
    config = function()
      local null_ls = require("null-ls")

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
    },
  };
  {'williamboman/mason.nvim',
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
      }
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  };

  -- Autocompletion
  {'hrsh7th/nvim-cmp',
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = {
          { name = "luasnip" }
        }
      }
      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          })
      })
    end
  };

  {'hrsh7th/cmp-nvim-lua',
    ft = "lua",
    config = function()
      require('cmp').setup {
        sources = {
          { name = "nvim_lua" }
        }
      }
    end
  },

  -- Snippets
  {'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    lazy = true,
  };

  {'RRethy/nvim-treesitter-endwise',
    lazy = true,
  };

  {'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
    event = "BufReadPre",
  };

  {'ojroques/vim-oscyank',
    cmd = "OSCYank",
  };

  {'zbirenbaum/copilot.lua',
    event = "VeryLazy",
    config = true,
  };

  {'gbprod/yanky.nvim',
    config = true,
    event = "VeryLazy",
  };

  {'feline-nvim/feline.nvim',
    config = function ()
      local components = require('feline.default_components').statusline.icons

      local navic = require("nvim-navic")
      table.insert(components.active[1], {
        provider = function()
          return navic.get_location()
        end,
        enabled = function()
          return navic.is_available()
        end,
        left_sep = {
          "  ",
          { str = "slant_left",
            hl = {
              fg = 'fg',
              bg = 'bg',
            }
          },
          " ",
        }
      })
      require('feline').setup({components = components})
    end,
    event = "VeryLazy",
  };
  {'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end
  };
}
