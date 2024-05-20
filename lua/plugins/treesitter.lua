return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = nil,
		branch = "master",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = true,
				ensure_installed = {
					"c",
					"r",
					"python",
					"markdown",
					"markdown_inline",
					"bash",
					"yaml",
					"json",
					"lua",
					"vim",
					"query",
					"vimdoc",
					"latex",
					"rnoweb",
					"html",
					"css",
				},
				highlight = {
					enable = true,
					-- disable = { "rnoweb", "help" }
				},
				-- indent = {
				--     enable = true,
				--     -- disable = { "r", "markdown" },
				-- },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
			})
			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			vim.o.foldenable = false
		end,
	},
}
