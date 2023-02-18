return {
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

  {'tpope/vim-rails',
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
      'nvim-lua/plenary.nvim',
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


  {'zbirenbaum/copilot.lua',
    event = "VeryLazy",
    config = true,
  };



  {'bfontaine/Brewfile.vim'},
}
