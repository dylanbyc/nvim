return {
	"jpalardy/vim-slime",
	config = function()
		-- Configuration for vim-slime
		vim.g.slime_target = "tmux"
		vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
		vim.g.slime_dont_ask_default = 1

		-- Key mappings for vim-slime
		vim.api.nvim_set_keymap("n", "<leader>ss", "<Plug>SlimeRegionSend", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("x", "<leader>ss", "<Plug>SlimeRegionSend", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>sc", "<Plug>SlimeParagraphSend", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>sl", "<Plug>SlimeLineSend", { noremap = false, silent = true })
	end,
}
