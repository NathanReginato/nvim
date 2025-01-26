return {
	"neovim/nvim-lspconfig",
	config = function()
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
		})

		require("lspconfig").gopls.setup({})
		require("lspconfig").golangci_lint_ls.setup({})

		require("lspconfig").ts_ls.setup({
			on_attach = function(client)
				-- Disable formatting for tsserver
				-- We're going to use prettier instead
				client.server_capabilities.documentFormattingProvider = false
			end,
		})

		-- Docker and Docker Compose
		require("lspconfig").dockerls.setup({})
		require("lspconfig").docker_compose_language_service.setup({})

		-- Terraformls should be used over terraform_lsp since it's more stable.
		require("lspconfig").terraformls.setup({})

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
		})

		require("lspconfig").bashls.setup({})
		require("lspconfig").css_variables.setup({})
		require("lspconfig").tailwindcss.setup({})

		-- Markdown functions (e.g., goto definition and reference link autocomplete)
		require("lspconfig").marksman.setup({})

		require("lspconfig").yamlls.setup({
			settings = {
				yaml = {
					schemas = {
						-- add custom schemas here [ <schema location> ] = <file match pattern>
						-- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
					},
				},
			},
		})
	end,
}
