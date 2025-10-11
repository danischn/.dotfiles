---------------------------------------------------------------
--- OPTIONS
---------------------------------------------------------------
vim.cmd.colorscheme("iben")
vim.opt.clipboard = "unnamedplus"

vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.laststatus = 2
vim.opt.showtabline = 0 
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.grepprg = "rg --vimgrep"

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25"

vim.opt.pumheight = 4
vim.opt.undofile = true
vim.opt.splitkeep = "topline"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.updatetime = 300
vim.opt.signcolumn = "no"

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.expandtab= true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = ".."


vim.opt.listchars = { tab = '>>', trail = '•', extends = "»", precedes = "«", nbsp= "+"}

vim.opt.winborder = 'single'
vim.opt.exrc = true
vim.g.c_syntax_for_h = true
vim.g.qf_disable_statusline = 1

vim.cmd("cabbrev cd tcd")
-- This is for making the hlsearch only work for the current window
vim.cmd.hi("clear Search")
vim.cmd.hi("clear IncSearch")

---------------------------------------------------------------
--- Keymaps
---------------------------------------------------------------
local map = vim.keymap.set

vim.g.mapleader = " "
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<esc>", "<cmd>nohlsearch<cr>")
map("n", "J", "mzJ`z")
map("n", "<leader>c", "gcc", { remap = true })
map("v", "<leader>c", "gc", { remap = true })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("t", "<esc>", "<C-\\><C-n>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<C-q>", function()
  local wins = #vim.api.nvim_tabpage_list_wins(0)
  if wins > 1 then
      vim.cmd.close()
  else
      vim.api.nvim_echo({{' Cant close last window in tab! ', "WarningMsg"}}, false, {})
  end
end)

map("n", "<leader>1", function()
  vim.o.cmdheight = 1 - vim.o.cmdheight
end, { desc = "Change cmdheight" })

map("n", "<leader>'", "<cmd>FzfLua files<cr>")
map("n", "<leader>/", "<cmd>FzfLua live_grep<cr>")
map("n", "<leader>h", "<cmd>FzfLua help_tags<cr>")
map("n", "<leader>m", "<cmd>FzfLua manpages<cr>")
map("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
map("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>")
---------------------------------------------------------------
--- Autocmds
---------------------------------------------------------------

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup("OnYankHighlight", {clear = true}),
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 50 })
  end,
})


vim.api.nvim_create_autocmd({"BufWinEnter", "VimEnter", "WinEnter"}, {
  callback = function()
    if vim.bo.filetype == "minifiles" then return end
    vim.wo.winhl = "Search:SchneiSearch,IncSearch:SchneiSearch"
  end
})

vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.filetype == "minifiles" then return end
       vim.wo.winhl = ""
  end
})


---------------------------------------------------------------
--- Plugins
---------------------------------------------------------------

local gh = "https://github.com/"
vim.pack.add({
  gh .. "nvim-treesitter/nvim-treesitter",
  gh .. "nvim-treesitter/nvim-treesitter-textobjects",
  gh .. "tpope/vim-surround",
  gh .. "williamboman/mason.nvim",
  gh .. "ibhagwan/fzf-lua",
  gh .. "stevearc/conform.nvim",
  gh .. "echasnovski/mini.files",
  gh .. "mfussenegger/nvim-dap",
  gh .. "dcampos/nvim-snippy",
  gh .. "tommcdo/vim-lion",
})

---------------------------------------------------------------
--- Enabling the plugins
---------------------------------------------------------------


require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@call.outer",
                ["ic"] = "@call.inner",
            },
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = false,
            node_decremental = '<BS>',
        }
    },
})

require("mason").setup()

require("conform").setup({
	formatters_by_ft = {
python = { "black" },
		markdown = { "prettier" },
		c = { "clang-format" },
		java = { "google-java-format" }, },
})

require("snippy").setup({
  mappings = {
      is = {
          ["<Tab>"] = "expand_or_advance",
          ["<S-Tab>"] = "previous",
      },
  },
  virtual_markers = {
      enabled = true,
      default = '_',
      empty = '_',
      hl_group = 'SnippyMarker',
  }
})
