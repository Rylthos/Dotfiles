vim.pack.add {
  {
    src = "https://github.com/f-person/git-blame.nvim.git",
  },
}

require("gitblame").setup {
  enabled = true,
  message_template = " <summary> • <date> • <author>",
  date_format = "%m-%d-%Y %H:%M:%S",
  virtual_text_column = 1,
}
