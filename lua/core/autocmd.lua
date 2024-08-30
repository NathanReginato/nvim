-- Create an event handler for the FileType autocommand
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function(args)
    vim.lsp.start({
      name = 'gopls',
      cmd = { 'gopls' },
      root_dir = vim.fn.getcwd()
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function(args)
    vim.api.nvim_command('write!')
    vim.fn.system(string.format("goimports -w %s", args.file))
    vim.fn.system(string.format("gofmt -w %s", args.file))
    vim.api.nvim_command('edit!')
    vim.api.nvim_command('write!')
  end,
})
