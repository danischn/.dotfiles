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
