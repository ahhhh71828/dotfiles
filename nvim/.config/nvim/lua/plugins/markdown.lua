return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim",
    },
    opts = {
      render_modes = { "n", "c", "t", "i" },
      anti_conceal = {
        enabled = false,
      },
      completions = { blink = { enabled = true } },
      file_types = { "markdown", "markdown.mdx", "codecompanion" },
      heading = {
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "markdown.mdx" },
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nvic"
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.keymap.set("n", "<leader>um", "<cmd>RenderMarkdown toggle<cr>", {
            buffer = true,
            desc = "Toggle Rendered Markdown",
          })
        end,
      })

      local diagnostic_state = {}
      local diagnostic_group = vim.api.nvim_create_augroup("markdown_writing_diagnostics", { clear = true })

      local function is_markdown(buf)
        local filetype = vim.bo[buf].filetype
        return filetype == "markdown" or filetype == "markdown.mdx"
      end

      vim.api.nvim_create_autocmd("InsertEnter", {
        group = diagnostic_group,
        callback = function(args)
          if not is_markdown(args.buf) then
            return
          end
          if diagnostic_state[args.buf] == nil then
            diagnostic_state[args.buf] = vim.diagnostic.is_enabled({ bufnr = args.buf })
          end
          vim.diagnostic.enable(false, { bufnr = args.buf })
        end,
      })

      vim.api.nvim_create_autocmd("InsertLeave", {
        group = diagnostic_group,
        callback = function(args)
          if not is_markdown(args.buf) then
            return
          end
          if diagnostic_state[args.buf] then
            vim.diagnostic.enable(true, { bufnr = args.buf })
          end
          diagnostic_state[args.buf] = nil
        end,
      })

      vim.api.nvim_create_autocmd("BufWipeout", {
        group = diagnostic_group,
        callback = function(args)
          diagnostic_state[args.buf] = nil
        end,
      })
    end,
  },
  {
    "bullets-vim/bullets.nvim",
    ft = { "markdown", "markdown.mdx" },
    opts = {
      enabled_file_types = { "markdown", "markdown.mdx" },
      enable_in_empty_buffers = false,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end,
  },
}
