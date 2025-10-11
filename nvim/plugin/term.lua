local function get_float_opts()
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  return {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "single",
  }
end

local m = { buf = -1, win = -1 }

function m.toggle_term()
  local win_opts = get_float_opts()
  if not vim.api.nvim_buf_is_valid(m.buf) then
    m.buf = vim.api.nvim_create_buf(true, true)
  end

  if vim.api.nvim_win_is_valid(m.win) then
    vim.api.nvim_win_hide(m.win)
  elseif vim.bo[m.buf].buftype ~= "terminal" then
    m.win = vim.api.nvim_open_win(m.buf, true, win_opts)
    vim.cmd.terminal()
    vim.cmd.startinsert()
  else
    m.win = vim.api.nvim_open_win(m.buf, true, win_opts)
    vim.cmd.startinsert()
  end
end


vim.keymap.set({"n", "t"}, "<C-g>", m.toggle_term)
