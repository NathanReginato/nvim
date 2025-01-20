-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "kanagawa-dragon" },
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("core.keymaps")

-- trigger autocomplete whenever a "." is typed
local triggers = { "." }
-- register function on the InsertCharPre event
-- https://neovim.io/doc/user/autocmd.html#InsertCharPre
vim.api.nvim_create_autocmd("InsertCharPre", {
	-- get the current buffer
	buffer = vim.api.nvim_get_current_buf(),
	callback = function()
		-- checks if the pop up menu is visible (pum = Pop Up Menu) and
		-- that there's nothing else important going on
		-- https://neovim.io/doc/user/builtin.html#pumvisible()
		-- https://neovim.io/doc/user/builtin.html#state()
		if vim.fn.pumvisible() == 1 or vim.fn.state("m") == "m" then
			return
		end
		-- get the current character
		local char = vim.v.char
		-- compare current character to table of trigger characters
		if vim.list_contains(triggers, char) then
			-- create the open omnifunc keybinding
			-- Note: I changed the keybinding from the documentation from
			-- <C-x><C-n> to <C-x><C-o> becuase I find it more useful.
			-- see the documentation for a list of all the completion types
			-- https://neovim.io/doc/user/insert.html#_7.-insert-mode-completion
			local key = vim.keycode("<C-x><C-o>")
			-- run the keybinding
			-- https://neovim.io/doc/user/api.html#nvim_feedkeys()
			vim.api.nvim_feedkeys(key, "m", false)
			-- becuase we're using Neovim's LSP client, 'omnifunc' is
			-- set to vim.lsp.omnifunc() which means we could forego the
			-- previous two lines and just use
			-- vim.lsp.omnifunc()
		end
	end
})
