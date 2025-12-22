return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
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
    -- TODO: these might have different ways to enable now?
    --   highlight = {
    --     enable = true,
    --     additional_vim_regex_highlighting = false,
    --   },
    --
    --   indent = {
    --     enable = true,
    --   },
    },
  },
  {
    'RRethy/nvim-treesitter-endwise',
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
}
