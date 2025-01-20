return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Set up the Go language server (gopls)
			require 'lspconfig'.gopls.setup {}

			-- Set up the Lua language server (sumneko_lua or lua-language-server)
			require 'lspconfig'.lua_ls.setup {
				settings = {
					Lua = {
						runtime = {
							-- Lua version (set to LuaJIT if you're using Neovim)
							version = 'LuaJIT', -- 'Lua' or 'LuaJIT'
						},
						diagnostics = {
							-- Enable to get diagnostics for undefined global variables (like `vim`)
							globals = { 'vim' },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Include runtime files
						},
						telemetry = {
							enable = false, -- Disable telemetry if you don't want to send data
						},
						format = {
							enable = false, -- Disable auto-formatting
						},
					},
				},
			}
		end,
	},
}
