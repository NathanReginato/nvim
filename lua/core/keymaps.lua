local keymap = vim.keymap

-- Telescope keybindings
local builtin = require('telescope.builtin')

-- If not in a git repository, just use find_files
local find_files_safe = function() 
	local git_dir = vim.fn.finddir('.git', vim.fn.getcwd())
	if git_dir ~= "" then 
		builtin.git_files() 
	else 
		builtin.find_files()
	end 
end

keymap.set('n', '<leader>ff', find_files_safe, {})
keymap.set('n', '<leader>fF', builtin.find_files, {})
keymap.set('n', '<leader>fw', builtin.live_grep, {})
keymap.set('n', '<leader>fW', builtin.grep_string, {})
keymap.set('n', '<leader>fo', builtin.oldfiles, {})
