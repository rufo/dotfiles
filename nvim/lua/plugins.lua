vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use {
	  'numToStr/Comment.nvim',
	  config = function()
		  require('Comment').setup()
	  end
  }

 --[[ use { 
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }]]
end)

