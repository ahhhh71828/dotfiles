-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.fn.has("wsl") == 1 and vim.fn.executable("clip.exe") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = [[powershell.exe -NoProfile -Command [Console]::Out.Write((Get-Clipboard -Raw))]],
      ["*"] = [[powershell.exe -NoProfile -Command [Console]::Out.Write((Get-Clipboard -Raw))]],
    },
    cache_enabled = 0,
  }
  vim.opt.clipboard = "unnamedplus"
end

-- 滑鼠交給 nvim：點一下移游標、按住拖曳選取。
-- 「拖曳放開就自動複製」由 keymaps.lua 的 <LeftRelease> 負責，
-- 由 nvim 自己複製的好處是不會把左邊的行號一起帶走。
vim.opt.mouse = "a"
