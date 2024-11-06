vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.g.mapleader = " "


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- NvimTree plugin
    {"nvim-tree/nvim-tree.lua"},
		
  -- Treesitter plugin
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    
    -- Dracula theme
    {"dracula/vim", name = "dracula"},
    
    -- Telescope plugin
    {
      'nvim-telescope/telescope.nvim', 
      tag = '0.1.0',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
		-- vim tmux navigator plugin
	 {
  "christoomey/vim-tmux-navigator",
			lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
},
    
    -- Obsidian plugin
    {
      "epwalsh/obsidian.nvim",
      version = "*",
      lazy = true,
      ft = "markdown",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      opts = {
        workspaces = {
          {
            name = "personal",
            path = "~/../../mnt/c/users/munya/oneDrive/The Blueprint",
          },
          {
            name = "work",
            path = "~/vaults/work",
          },
        },
      },
    }
  },
  install = { colorscheme = { "dracula" } },
  checker = { enabled = true },
})

-- Treesitter configuration
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript"},
  highlight = { enable = true },
  indent = { enable = true },
})

-- NvimTree configuration
local tree = require("nvim-tree")
tree.setup()

-- Telescope keybindings
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- NvimTree keybinding
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
