return {
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { verible = {} } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "verilog", "asm" } },
  },
}
