return {
  {
    "keaising/im-select.nvim",
    cond = vim.fn.executable("macism") == 1,
    event = "VeryLazy",
    config = function()
      require("im_select").setup({
        default_im_select = "com.apple.keylayout.ABC",
        default_command = "macism",
      })
    end,
  },
}
