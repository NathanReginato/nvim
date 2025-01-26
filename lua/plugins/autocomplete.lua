return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"amarakon/nvim-cmp-fonts",
		"L3MON4D3/LuaSnip",
		{ "tzachar/cmp-ai", dependencies = "nvim-lua/plenary.nvim" },
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			view = {
				entries = "custom", -- can be "custom", "wildmenu" or "native"
			},
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "cmp_ai" },
				{ name = "nvim_lsp_signature_help" },
				-- Most font names have spaces in them. However, nvim-cmp restarts the
				-- completion after a space, disallowing you to complete a font name
				-- with spaces. The `space_filter` option is a way to get around this by
				-- using a different character to represent spaces. If you wish, you can
				-- set this option to a space character, but you know the downside of
				-- that.
				{ name = "fonts", option = { space_filter = "-" } },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?`
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':'
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- You will also need to make sure you have the OpenAI api key in you environment, OPENAI_API_KEY.
		require("cmp_ai.config"):setup({
			max_lines = 1000,
			provider = "OpenAI",
			provider_options = {
				model = "gpt-4",
			},
			notify = true,
			notify_callback = function(msg)
				vim.notify(msg)
			end,
			run_on_every_keystroke = true,
			ignored_file_types = {
				-- default is not to ignore
				-- uncomment to ignore in lua:
				-- lua = true
			},
		})
	end,
}
