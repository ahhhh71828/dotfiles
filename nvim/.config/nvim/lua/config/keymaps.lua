-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- kitty 把 cmd+z 映射成 0x1f（Ctrl+_）送過來，這裡接成「復原」，
-- 讓 cmd+z 在 nvim 和 shell 裡是同一個動作。
-- 對接處：~/.config/kitty/keys-macos.conf 的 `map cmd+z send_text all \x1f`（Linux 在 keys-linux.conf，改用 ctrl）
vim.keymap.set("n", "<C-_>", "u", { desc = "復原（cmd+z）" })
vim.keymap.set("i", "<C-_>", "<C-o>u", { desc = "復原（cmd+z）" })
vim.keymap.set("v", "<C-_>", "<Esc>u", { desc = "復原（cmd+z）" })

-- 滑鼠拖曳選取，手一放開就複製到系統剪貼簿，行為和 shell 的選取即複製一致。
-- gv 是複製完把選取範圍留著，不會反白消失。
vim.keymap.set("x", "<LeftRelease>", '"+ygv', { desc = "拖曳選取後自動複製" })

-- kitty 把 cmd+shift+z 映射成 0x1e（Ctrl+^）送過來，接成「重做」。
vim.keymap.set("n", "<C-^>", "<C-r>", { desc = "重做（cmd+shift+z）" })
vim.keymap.set("i", "<C-^>", "<C-o><C-r>", { desc = "重做（cmd+shift+z）" })

-- kitty 把 cmd+c 映射成 0x1d（Ctrl+]）送過來，接成「複製」。
-- 有選取就複製選取，沒選取就複製游標所在的整行（和 VS Code 一樣）。
vim.keymap.set("x", "<C-]>", '"+y', { desc = "複製（cmd+c）" })
vim.keymap.set("n", "<C-]>", '"+yy', { desc = "複製整行（cmd+c）" })
