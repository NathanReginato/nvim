return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip"
		},
		config = function()
			local cmp = require 'cmp'
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				sources = cmp.config.sources(
					{
						{ name = 'buffer' },
					}
				)
			})
		end
	},
}
