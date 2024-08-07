local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- lua functions that other plugins may use
  use("nvim-lua/plenary.nvim")

  -- theme
  use("ellisonleao/gruvbox.nvim")

  -- window management
  use("christoomey/vim-tmux-navigator")
  use("szw/vim-maximizer")

  -- convenience
  use("tpope/vim-surround")
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- icons
  use("kyazdani42/nvim-web-devicons")

  -- status-line
  use("nvim-lualine/lualine.nvim")

  -- telescope/fuzzy-finding
  -- dependency for better sorting performanc
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  -- fuzzy finder
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  -- autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- lsp installation and management
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- lsp config
  use("neovim/nvim-lspconfig")

  -- lsp integration with other plugins
  use("hrsh7th/cmp-nvim-lsp") -- adds lsp source for autocompletion
  use({
    "nvimdev/lspsaga.nvim",   -- adds ui for lsp info
    branch = "main",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })

  -- lsp signature help
  use("ray-x/lsp_signature.nvim")

  -- vscode like icons for lsp
  use("onsails/lspkind.nvim")

  -- linters and formatters
  use("stevearc/conform.nvim")

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- brackets
  use("windwp/nvim-autopairs")
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

  -- git integration
  use("lewis6991/gitsigns.nvim")

  -- vimtex
  use("lervag/vimtex")

  -- typst
  use {
    'chomosuke/typst-preview.nvim',
    tag = 'v0.3.*',
    run = function() require 'typst-preview'.update() end,
  }

  use { 'kaarmu/typst.vim', ft = { 'typst' } }

  -- haskell-tools
  -- use("mrcjkb/haskell-tools.nvim")
end)
