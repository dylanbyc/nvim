return {
	{
		"R-nvim/R.nvim",
		dependencies = "windwp/nvim-autopairs",
		config = function()
			local opts = {
				hook = {
					on_filetype = function()
						-- This function will be called at the FileType event
						-- of files supported by R.nvim. This is an
						-- opportunity to create mappings local to buffers.
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
						vim.api.nvim_buf_set_keymap(0, "i", "MM", " %>% <esc>i", {})
						vim.api.nvim_buf_set_keymap(0, "n", "MM", "i %>% <esc>", {})
					end,
				},
				min_editor_width = 78,
				rconsole_width = 78,
				listmethods = true,
				R_args = { "--no-save" },
				-- R_args = {"-d", "'valgrind --log-file=/dev/shm/valgrind_log_R'"},
				disable_cmds = {
					"RClearConsole",
					"RCustomStart",
					"RDputObj",
					"RInsertLineOutput",
					"RMakeHTML",
					"RMakeODT",
					"RMakePDFK",
					"RMakePDFKb",
					"RMakeWord",
					"RSPlot",
					"RSaveClose",
					"RViewDFa",
					"RViewDFs",
					"RViewDFv",
				},
			}
			if vim.env.R_AUTO_START == "true" then
				opts.auto_start = 1
				opts.objbr_auto_start = true
			end
			require("r").setup(opts)
		end,
		lazy = false,
	},
}
