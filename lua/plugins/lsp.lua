return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local on_attach = function(_, bufnr)
				vim.keymap.set(
					"n",
					"gd",
					vim.lsp.buf.definition,
					{ noremap = true, silent = true, desc = "LSP Go to Definition" }
				)
				vim.keymap.set(
					"n",
					"<leader>ld",
					vim.diagnostic.open_float,
					{ noremap = true, silent = true, desc = "Show Line Diagnostics" }
				)
				vim.keymap.set(
					"n",
					"<leader>ln",
					vim.diagnostic.goto_next,
					{ desc = "Go to Next Diagnostic", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>lp",
					vim.diagnostic.goto_prev,
					{ desc = "Go to Previous Diagnostic", buffer = bufnr }
				)
				vim.keymap.set(
					"n",
					"<leader>lq",
					vim.diagnostic.setloclist,
					{ noremap = true, silent = true, desc = "Open Diagnostics List" }
				)
				local telescope_builtin = require("telescope.builtin")

				vim.keymap.set("n", "<leader>li", function()
					telescope_builtin.lsp_implementations({
						layout_strategy = "cursor",
					})
				end, { noremap = true, silent = true, desc = "LSP Code Actions quickfix" })

				vim.keymap.set(
					"n",
					"<leader>la",
					vim.lsp.buf.code_action,
					{ noremap = true, silent = true, desc = "LSP Code Actions (Telescope)" }
				)

				require("telescope").load_extension("ui-select")
			end
			-- Set up the Lua language server
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Lua version (set to LuaJIT if you're using Neovim)
							version = "LuaJIT", -- 'Lua' or 'LuaJIT'
						},
						diagnostics = {
							-- Enable to get diagnostics for undefined global variables (like `vim`)
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Include runtime files
						},
						format = {
							-- Allow conform to do formating
							enable = false,
						},
					},
				},
				on_attach = on_attach,
			})

			require("lspconfig").gopls.setup({
				on_attach = on_attach,
			})
			require("lspconfig").golangci_lint_ls.setup({})

			require("lspconfig").ts_ls.setup({
				on_attach = function(client, bufnr)
					-- Disable formatting for tsserver
					-- We're going to use prettier instead
					client.server_capabilities.documentFormattingProvider = false
					on_attach(client, bufnr)
				end,
			})

			-- Docker and Docker Compose
			require("lspconfig").dockerls.setup({
				on_attach = on_attach,
			})
			require("lspconfig").docker_compose_language_service.setup({
				on_attach = on_attach,
			})

			-- Terraformls should be used over terraform_lsp since it's more stable.
			require("lspconfig").terraformls.setup({
				on_attach = on_attach,
			})

			-- By default azure-pipelines-ls will only work in files named azure-pipelines.yml, this can be changed by providing additional settings like so:
			-- The Azure Pipelines LSP is a fork of yaml-language-server and as such the same settings can be passed to it as yaml-language-server.
			require("lspconfig").azure_pipelines_ls.setup({
				settings = {
					yaml = {
						schemas = {
							["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
								"/azure-pipeline*.y*l",
								"/*.azure*",
								"Azure-Pipelines/**/*.y*l",
								"Pipelines/*.y*l",
							},
						},
					},
				},
				on_attach = on_attach,
			})

			require("lspconfig").bashls.setup({

				on_attach = on_attach,
			})
			require("lspconfig").css_variables.setup({
				on_attach = on_attach,
			})
			require("lspconfig").tailwindcss.setup({
				on_attach = on_attach,
			})

			-- Markdown functions (e.g., goto definition and reference link autocomplete)
			require("lspconfig").marksman.setup({
				on_attach = on_attach,
			})

			require("lspconfig").yamlls.setup({
				settings = {
					yaml = {
						schemas = {
							-- add custom schemas here [ <schema location> ] = <file match pattern>
							-- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						},
					},
				},
				on_attach = on_attach,
			})
		end,
	},
}
