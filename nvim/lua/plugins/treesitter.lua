return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts = {
      ensure_installed = {
        'ruby',
        'lua',
        'json',
        'dockerfile',
        'javascript',
        'typescript',
        'bash',
        'comment',
        'css',
        'go',
        'html',
        'python',
        'regex',
        'scss',
        'toml',
        'vim',
        'yaml',
        'tsx',
        'vue',
        'make',
        'c',
        'markdown',
        'markdown_inline',
        'vimdoc',
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
      require('nvim-treesitter.configs').setup(opts)
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = { 'RRethy/nvim-treesitter-endwise' },
  },
}
