return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "bold",
        },
      },
      groups = {
        -- 不覆寫 Normal 的底色：carbonfox 原生就是 #161616，kitty 與
        -- tmux 也都設成同一個值，這樣從終端切進編輯器時背景不會跳。
        -- 以下只調整「浮起層」與重點色，全部取自 carbonfox 自己的色階
        -- (bg2 #252525 / bg3 #353535 / bg4 #535353 / bg0 #0c0c0c)。
        carbonfox = {
          -- 游標行維持極弱的存在感：#252525 相對 #161616 的亮度差，
          -- 與先前 #111111 相對純黑的差幾乎相同。
          CursorLine = { bg = "#252525" },
          -- 柔粉是「當下位置」的專屬色，與 starship 的 ❯ 和 kitty 游標同色。
          CursorLineNr = { fg = "#F5A6D6", bg = "#252525", style = "bold" },
          -- 行號刻意比主題預設更暗；改用中性灰而非原本的藍灰，避免色偏。
          LineNr = { fg = "#535353" },
          -- 主題預設讓分隔線比背景更暗而幾乎隱形，這裡改成比背景亮一階。
          WinSeparator = { fg = "#353535" },
          -- 作用中的狀態列浮起，非作用中的沉下，對應 kitty 分頁列的邏輯。
          StatusLine = { bg = "#2a2a2a" },
          StatusLineNC = { bg = "#0c0c0c" },
        },
      },
    },
  },
}
