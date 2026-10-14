# 全域 AI 工作規則

這份文件是 Codex 與 Claude Code 的 user-level bootstrap。專案事實、進度與交接內容必須寫在專案本身，不得只留在聊天紀錄或 agent 的自動記憶。

## 語言與術語

- 使用繁體中文。技術關係採性別中立且能直接表達結構或功能的用語。
- 不把 `parent`、`child` 等詞機械翻譯為「父／母／子」來稱呼資料結構、module hierarchy、process 或其他技術關係。依情境使用「上層／下層」「包含者／被包含者」「來源／目標」等精確描述；沒有自然且精確的中文時，保留英文原文並在第一次出現時解釋。
- 外部規格、API、signal、identifier 或既有程式碼中的正式名稱保留原文，不擅自改名。完整規則見 `/Users/ahh/Punta/file-system.md` §8.8。

## 個人規則與脈絡

- `~/Punta/index.md` 是我的個人規則與脈絡的進入點，適用於所有工作目錄，不只在 `~/Punta` 裡工作時。
- 每次任務開始先讀 `index.md`，再依它的路由表判斷這次需要讀哪些檔案，不要一次讀完整個目錄。
- `~/Punta/working-with-me.md` 規範怎麼回答我、怎麼提做法、動檔案前要先問，任何任務都適用。
- Punta 規則與本文件的優先順序尚未定義。兩者衝突時先問我，不得自行裁定。

## 專案邊界與啟動流程

- 每次開始工作，先從目前工作目錄向上尋找最近的 `.ai/README.md`。
- 找到時，以該 `.ai/` 的父目錄作為目前 AI project root，並完全依照 `README.md` 所列 reading order 讀取檔案。
- 若向上找到多個 `.ai/README.md`，只使用距離目前工作目錄最近的一個 project boundary。
- 若找不到 `.ai/README.md`，將目前位置視為尚未採用此 protocol；除非使用者明確要求並確認它是長期維護的 project root，否則不要建立 `.ai/`。
- `.ai/` 只屬於 persistent project root。不要在 `Downloads/`、`Inbox/`、`Resources/`、素材庫、收件區、暫存目錄、年份分類或一般內容子資料夾中自動建立 `.ai/`。
- 不要在已有 project boundary 的子目錄重複建立 `.ai/`。

## Source of truth

- 檔案系統中的專案文件是 source of truth；聊天紀錄、對話摘要與 agent 自動記憶只能當線索，不能取代檔案。
- 開工前先讀取目前檔案與狀態，不要假設上一次對話仍然正確。
- 發現聊天內容與檔案衝突時，以目前檔案及使用者最新明確指示為準，並在必要時標示差異。

## `.ai/` 文件規則

- `.ai/README.md` 是固定入口檔，也是 `UPPER_SNAKE_CASE.md` 規則的唯一命名例外。
- `.ai/` 內其他 AI 控制文件一律使用 `UPPER_SNAKE_CASE.md`，例如 `INSTRUCTIONS.md`、`CURRENT_STATE.md`、`HANDOFF.md`、`LOG.md`。
- `CURRENT_STATE.md` 記錄目前已驗證的真實狀態；更新時保持精簡並移除過時資訊。
- `HANDOFF.md` 記錄下一位 agent 需要知道的待辦、阻塞、風險與接續位置。
- `LOG.md` 是 chronological work log，只在 meaningful work 後追加簡短紀錄。

## 工作結束與人類紀錄

- Meaningful work 包括：改變檔案或環境、完成一個可辨識階段、產生新決策、發現重要限制、留下待辦或阻塞。
- Meaningful work 結束時，依實際狀況更新 `CURRENT_STATE.md`、`HANDOFF.md`，並在 `LOG.md` 追加紀錄。
- `Records/` 是給使用者閱讀的長期紀錄。只有當內容對使用者的決策、理解或未來追蹤有價值時才更新；不要把每次 agent 操作都抄進去。
- `Records/` 內文件使用人類可讀的 `Title-Kebab.md` 命名，正文使用繁體中文。
- 未經使用者明確要求，不要 commit、push、建立 PR，或改寫 Git 歷史。

## 變更原則

- 先盤點再修改，採取可逆且範圍最小的變更。
- 不要因為啟用 protocol 就搬動、重新命名或刪除既有內容。
- 保留外部原始檔名與來源資訊；技術檔案與程式碼遵循各自生態的命名慣例。
