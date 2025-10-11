require("fzf-lua").setup({
  defaults = {
    file_icons = false,
    git_icons = false,
  },
  winopts = {
    border = "single",
    preview = {
      layout = "vertical",
      delay = 10,
    },
  },
  files = {
    winopts = {
      height = 0.3,
      width = 0.6,
    },
    fd_opts = [[--color=always --type f --follow --exclude .git]],
    previewer = false,
  },
  grep = {
    no_ignore = true,
  },
  manpages = {
    winopts = {
      height = 0.3,
      width = 0.5,
    },
    previewer = false,
  },
  helptags = {
    winopts = {
      height = 0.3,
      width = 0.7,
    },
    previewer = false,
  }
})

local function new_tab()
    local fzf = require"fzf-lua"
    local opts = {}
    opts.prompt = "Open item in new tab: "
    opts.winopts = { height = 0.3, width = 0.6}
    opts.actions = {
        ['default'] = function(selected)
            local item = vim.fn.getenv("HOME") .. "/" .. selected[1]
            local dir = vim.fn.fnamemodify(item, ":p:h") .. "/"
            if item == dir then
              vim.cmd("$tabnew")
            else
              vim.cmd("$tabnew " .. item)
            end
            vim.cmd.tcd(dir)
        end
    }
    fzf.fzf_exec("fd --hidden  --color=always --base-directory $HOME", opts)
end

vim.keymap.set("n", "<leader>t", new_tab)

