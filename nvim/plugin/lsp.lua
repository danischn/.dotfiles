vim.lsp.enable({ "clangd", "luals", "tinymist"})

vim.keymap.set("n", "<leader>n", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({bufnr = 0}), {bufnr = 0})
	vim.cmd.redrawstatus()
end)

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("LspDaniel", {clear = true}),
  callback = function()
    vim.diagnostic.enable(false, {bufnr = 0})
  end,
})
