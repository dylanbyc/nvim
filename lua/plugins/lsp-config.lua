return {

	{
		-- Must be before lspconfig
		"folke/neodev.nvim", -- completion of vim module and standard lua functions
		config = function()
			require("neodev").setup({})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	},

	{
		"williamboman/mason.nvim",
		config = true,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Setup lspconfig.
			local cmpcapablts =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local lspcfg = require("lspconfig")

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(_, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				-- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

				-- Enable language server completion triggered by <c-x><c-o> if not enabling autocompletion
				vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Mappings.
				local opts = { noremap = true, silent = true }

				-- See `:help vim.lsp.*` for documentation on any of the below functions
				buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				buf_set_keymap("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
				buf_set_keymap("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
				buf_set_keymap(
					"n",
					"<Leader>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					opts
				)
				buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				buf_set_keymap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				buf_set_keymap("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
				buf_set_keymap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
			end

			vim.diagnostic.config({
				severity_sort = true,
			})

			-- map buffer local keybindings when the language server attaches
			lspcfg["pyright"].setup({
				on_attach = on_attach,
				flags = { debounce_text_changes = 150 },
				capabilities = cmpcapablts,
			})
			lspcfg["clangd"].setup({
				on_attach = on_attach,
				flags = { debounce_text_changes = 150 },
				capabilities = cmpcapablts,
			})
			lspcfg["vimls"].setup({
				on_attach = on_attach,
				flags = { debounce_text_changes = 150 },
				capabilities = cmpcapablts,
			})

			lspcfg["r_language_server"].setup({
				on_attach = on_attach,
				flags = { debounce_text_changes = 150 },
				capabilities = cmpcapablts,
			})

			-- Segundo comentário na internet, ltex com n-grams é tão bom
			-- quanto grammarly para correção gramatical.
			-- Não instalar porque tem memory leak
			-- lspcfg['ltex'].setup { }

			-- local runtime_path = vim.split(package.path, ';')
			-- table.insert(runtime_path, "lua/?.lua")
			-- table.insert(runtime_path, "lua/?/init.lua")

			lspcfg["lua_ls"].setup({
				on_attach = on_attach,
				flags = { debounce_text_changes = 150 },
				capabilities = cmpcapablts,
				settings = {
					Lua = {
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = {
								-- for neovim plugins:
								vim.env.VIMRUNTIME,
								-- "~/.local/share/nvim/lazy/neodev.nvim/types/stable",
								"~/.local/share/nvim/lazy/neodev.nvim/types/nightly",
							},
							-- Diable the message "Do you need to configure your environment as luassert"
							-- See: https://github.com/sumneko/lua-language-server/discussions/1688
							-- checkThirdParty = false,

							-- Required by obslua.lua
							-- preloadFileSize = 500000,
						},
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Setup your lua path
							-- path = runtime_path,
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						completion = { callSnippet = "Replace" },
						telemetry = {
							enable = false,
						},
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "LspDiagnosticsDefaultError" })

			vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "LspDiagnosticsDefaultWarning" })

			vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "LspDiagnosticsDefaultInformation" })

			vim.fn.sign_define("DiagnosticSignHint", { text = "⚑", texthl = "LspDiagnosticsDefaultHint" })
		end,
	},
}
