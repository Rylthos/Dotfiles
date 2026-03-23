return {
  "Dkendal/nvim-alternate",
  lazy = false,
  opts = {
    rules = {
      { pattern = { "(.+).c(pp?)$", "%1.h%2" }},
      { pattern = { "(.+).h(pp?)$", "%1.c%2" }},
    },
  },
  keys = {
    { "<leader>fs", "<plug>(alternate-edit)" },
  }
}
