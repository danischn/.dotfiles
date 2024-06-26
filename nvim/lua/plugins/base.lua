return {
	--Colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		version = "3.0.0",
		config = function()
			vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
	--Surround
	{
		"kylechui/nvim-surround",
		version = "*",
		event = { "BufRead", "BufNewFile" },
		config = true,
	},
	--Comment
	{
		"numToStr/Comment.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = {
			toggler = {
				line = "<leader>c",
			},
			opleader = {
				line = "<leader>c",
			},
		},
	},
	--Zenmode
	{
		"folke/zen-mode.nvim",
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" } },
		opts = {
			window = {
				width = 110,
			},
			plugins = {
				options = {
					laststatus = 0,
				},
				tmux = {
					enabled = true,
				},
			},
		},
	},
	--File explorer
	{
		"echasnovski/mini.files",
		version = false,
		keys = { { "<leader>e", "<cmd>lua MiniFiles.open()<cr>", desc = "Explorer" } },
		opts = {
			mappings = {
				go_in_plus = "l",
				synchronize = "<cr>",
			},
			windows = {
				max_number = 3,
				width_focus = 28,
				width_nofocus = 28,
			},
			options = {
				permanent_delete = false,
			},
		},
	},
	-- Nice when working with md-files
	{
		"jakewvincent/mkdnflow.nvim",
		ft = "markdown",
		opts = {},
	},
}
