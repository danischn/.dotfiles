vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = vim.api.nvim_create_augroup("AutoOpenQF", { clear = true }),
  callback = function()
    local qf_list = vim.fn.getqflist()
    if #qf_list > 0 then
      vim.cmd.copen()
    end
  end,
})

local function toggle_qf()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end

-- vim.keymap.set("n", "<C-c>", toggle_qf)
--
-- vim.api.nvim_create_autocmd("FileType", {
--   group = vim.api.nvim_create_augroup("QfKeymaps", { clear = true }),
--   pattern = "qf",
--   callback = function()
--     vim.keymap.set("n", "j", ":cnext<cr><C-w>p", { buffer = true })
--     vim.keymap.set("n", "k", ":cprev<cr><C-w>p", { buffer = true })
--   end,
-- })

