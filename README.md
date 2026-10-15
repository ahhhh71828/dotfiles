# dotfiles

我的終端機與編輯器設定。在 kitty 裡，tmux、nvim、fish、bash 用同一組深色配色（底色 `#161616`）和同一組快捷鍵，切換工具時畫面和按鍵行為一致。

配色和快捷鍵的轉換寫在 kitty 的設定裡。改用其他終端機（例如 Windows Terminal）時不會自動帶過去：配色可以照下面的「Windows Terminal 配色」設定，快捷鍵的差異寫在「快捷鍵」一節。

## 內容

| 資料夾 | 設定什麼 | macOS | Linux / WSL | Windows（PowerShell） |
|---|---|---|---|---|
| `nvim` | Neovim（LazyVim） | ✅ | ✅ | ✅ |
| `starship` | 命令列提示列 | ✅ | ✅ | ✅ |
| `fish` | fish shell | ✅ | ✅ | ❌ |
| `bash`、`shell` | bash，外觀與 fish 一致；`shell` 放兩者共用的檔案顏色 | ✅ | ✅ | ❌ |
| `tmux` | 終端機分割視窗 | ✅ | ✅ | ❌ |
| `kitty` | 終端機程式 | ✅ | ✅（WSL 除外） | ❌ |

nvim 已開啟這些語言的補全、錯誤提示與語法高亮：Python、TypeScript、JSON、YAML、Markdown、TOML、Rust、C/C++、Verilog/SystemVerilog、組合語言。

## 安裝：macOS

1. 安裝需要的工具和字型：

   ```bash
   brew install git stow fish neovim tmux starship eza ripgrep fd node python
   ```

   ```bash
   brew install --cask kitty font-atkynson-mono-nerd-font
   ```

2. 下載這個 repo：

   ```bash
   git clone https://github.com/ahhhh71828/dotfiles.git ~/dotfiles
   ```

3. 如果你已經有自己的設定，先改名保留，不然下一步會失敗。只需要處理你有的那幾個：

   ```bash
   mv ~/.config/nvim ~/.config/nvim.old
   ```

   ```bash
   mv ~/.config/fish ~/.config/fish.old
   ```

   ```bash
   mv ~/.tmux.conf ~/.tmux.conf.old
   ```

4. 用 stow 把設定連到家目錄。stow 會在家目錄建立指向 `~/dotfiles` 的捷徑，之後改 `~/dotfiles` 裡的檔案就會直接生效。只想要部分設定的話，只列你要的資料夾：

   ```bash
   cd ~/dotfiles
   ```

   ```bash
   stow nvim starship fish tmux kitty bash shell
   ```

5. （可選）把 fish 設成預設 shell：

   ```bash
   echo $(which fish) | sudo tee -a /etc/shells
   ```

   ```bash
   chsh -s $(which fish)
   ```

6. 打開 nvim。第一次會自動下載 plugin 和各語言的工具，等它跑完再重開一次。

## 安裝：Linux / WSL

1. 安裝基本工具：

   ```bash
   sudo apt update
   ```

   ```bash
   sudo apt install git stow fish tmux ripgrep fd-find build-essential curl unzip nodejs npm python3-venv
   ```

   `build-essential` 是 C 編譯器，nvim 編譯語法高亮要用；`nodejs`、`npm`、`python3-venv` 是 nvim 自動安裝各語言工具時要用的。

2. 另外安裝：
   - **Neovim 0.11.2 以上**：apt 的版本通常太舊，照 [Neovim 官方說明](https://github.com/neovim/neovim/blob/master/INSTALL.md) 安裝
   - **starship**：照 [starship 官網](https://starship.rs/) 安裝
   - **Nerd Font**：到 [Nerd Fonts](https://www.nerdfonts.com/font-downloads) 下載 AtkynsonMono。WSL 要裝在 Windows 那一側，再到 Windows Terminal 選這個字型
   - **eza**（可選）：讓 `ls` 有顏色和圖示，沒裝會自動改用一般的 `ls`

3. 接著照 macOS 的第 2 到 6 步做。WSL 沒有 kitty，第 4 步把 `kitty` 拿掉。

## 安裝：Windows（PowerShell）

Windows 上只能用 nvim 和 starship。想用整套設定的話，請改裝 WSL，再照上面 Linux / WSL 的步驟做。

1. 安裝工具：

   ```powershell
   winget install Git.Git
   ```

   ```powershell
   winget install Neovim.Neovim
   ```

   ```powershell
   winget install Starship.Starship
   ```

   ```powershell
   winget install OpenJS.NodeJS.LTS
   ```

   ```powershell
   winget install Python.Python.3.12
   ```

   Node.js 和 Python 是 nvim 自動安裝各語言工具時要用的。字型到 [Nerd Fonts](https://www.nerdfonts.com/font-downloads) 下載 AtkynsonMono，裝好後到 Windows Terminal 的設定裡選它。nvim 的語法高亮還需要 C 編譯器，裝法見 [LazyVim 安裝說明](https://lazyvim.github.io/installation)。

2. 下載這個 repo：

   ```powershell
   git clone https://github.com/ahhhh71828/dotfiles.git $HOME\dotfiles
   ```

3. 複製 nvim 設定。如果已經有 `$env:LOCALAPPDATA\nvim`，先執行第一行改名保留：

   ```powershell
   Rename-Item $env:LOCALAPPDATA\nvim nvim.old
   ```

   ```powershell
   Copy-Item -Recurse $HOME\dotfiles\nvim\.config\nvim $env:LOCALAPPDATA\nvim
   ```

4. 設定 starship：

   ```powershell
   New-Item -ItemType Directory -Force $HOME\.config | Out-Null
   ```

   ```powershell
   Copy-Item $HOME\dotfiles\starship\.config\starship.toml $HOME\.config\
   ```

   ```powershell
   if (!(Test-Path $PROFILE)) { New-Item -Force $PROFILE | Out-Null }
   ```

   ```powershell
   Add-Content $PROFILE 'Invoke-Expression (&starship init powershell)'
   ```

5. 重開 PowerShell，再打開 nvim 等它下載完 plugin。

Windows 上是複製檔案，不是捷徑。之後這個 repo 更新的話，要重新複製一次。

## Windows Terminal 配色

用 WSL 或 PowerShell 時，可以讓 Windows Terminal 用跟 kitty 一樣的顏色：

1. 打開 Windows Terminal，按 `ctrl+,` 開設定，點左下角「開啟 JSON 檔案」
2. 把下面這段加進 `"schemes": [ ... ]` 的中括號裡。裡面已經有其他配色的話，記得在前一個配色的 `}` 後面加逗號
3. 回到設定，在你用的設定檔（例如 Ubuntu）→「外觀」→「色彩配置」選 `dotfiles`

```json
{
    "name": "dotfiles",
    "background": "#161616",
    "foreground": "#F2F4F8",
    "cursorColor": "#F5A6D6",
    "selectionBackground": "#484848",
    "black": "#282828",
    "red": "#EE5396",
    "green": "#25BE6A",
    "yellow": "#08BDBA",
    "blue": "#78A9FF",
    "purple": "#BE95FF",
    "cyan": "#33B1FF",
    "white": "#DFDFE0",
    "brightBlack": "#484848",
    "brightRed": "#F16DA6",
    "brightGreen": "#46C880",
    "brightYellow": "#2DC7C4",
    "brightBlue": "#8CB6FF",
    "brightPurple": "#C8A5FF",
    "brightCyan": "#52BDFF",
    "brightWhite": "#E4E4E5"
}
```

## 快捷鍵

### kitty（同一顆鍵在 fish、bash、nvim 裡做同一件事）

| macOS | Linux | 動作 |
|---|---|---|
| `cmd+z` | `ctrl+z` | 復原 |
| `cmd+shift+z` | `ctrl+shift+z` | 重做 |
| `cmd+c` | `ctrl+c` | 複製。macOS：在 shell 裡複製正在打的那行，在 nvim 裡複製選取範圍。Linux：有反白就複製，沒有就中斷正在跑的程式 |
| — | `ctrl+v` | 貼上 |

在 Linux 的 kitty 裡，`ctrl+z` 被拿來當復原，所以不能再用它暫停程式。

Windows Terminal 沒有這組轉換，所以在 WSL 裡：

- fish、bash、nvim 都**沒有**上表的復原和重做快捷鍵，要用各自原本的按鍵，例如 nvim 的 `u` 和 `ctrl+r`
- `ctrl+z` 是終端機原本的「暫停正在跑的程式」，打 `fg` 可以讓它繼續
- 複製貼上用 Windows Terminal 自己的：有反白時 `ctrl+c` 複製，`ctrl+v` 貼上

### tmux

先按 prefix `ctrl+a`，放開後再按下面的鍵：

| 按鍵 | 動作 |
|---|---|
| `\|` | 左右分割 |
| `-` | 上下分割 |
| `h` `j` `k` `l` | 移到左、下、上、右的 pane |
| `r` | 重新載入設定 |
| `[` | 進入複製模式：`v` 開始選取，`y` 複製 |
| `]` | 貼上剛才在 tmux 裡複製的內容 |

`y` 複製的內容會存在 tmux 裡，同時送到系統剪貼簿，所以也能貼到其他 App。送到系統剪貼簿這一步要終端機支援，kitty 和 Windows Terminal 都支援。

滑鼠也可以用：點擊切換 pane，拖曳邊框調整大小。

### nvim

LazyVim 的預設快捷鍵見 [LazyVim keymaps](https://lazyvim.github.io/keymaps)，按 `空白鍵` 會跳出提示。另外有：

- **emoji**：在 Markdown 的輸入模式打 `:` 加英文名字，例如 `:hea`，會跳出 emoji 讓你選。在一般模式按 `空白鍵` → `s` → `i` 可以用名字搜尋 emoji 和圖示
- **輸入法自動切換（只有 macOS）**：離開輸入模式時切回英文，回到輸入模式時切回上次的輸入法。需要先依序執行 `brew tap laishulu/homebrew`、`brew trust --formula laishulu/homebrew/macism`、`brew install macism`，並把 `lua/plugins/im-select.lua` 裡的 `com.apple.keylayout.ABC` 改成你的英文輸入法代號。在英文輸入法下執行 `macism` 就會印出代號

## 自己的設定放哪裡

只屬於你這台電腦的 fish 設定，例如 PATH 或自己的 function，寫在 `fish/.config/fish/conf.d/local.fish`。這個檔案在 `.gitignore` 裡，不會被 commit，fish 啟動時會自動讀它。

## 可選工具

| 工具 | 用途 | 沒裝的話 |
|---|---|---|
| [ble.sh](https://github.com/akinomyoga/ble.sh) | bash 打字顏色與上面的快捷鍵，裝法寫在 `bash/.bashrc` 開頭 | bash 照常可用，只是沒有顏色和快捷鍵 |
| `yt-dlp`、`ffmpeg` | fish 的 `ytdl` 指令，下載影片或音訊 | `ytdl` 會提示你安裝 |
| [rustup](https://rustup.rs/) | Rust 開發，nvim 的 Rust 支援另外需要 `rustup component add rust-analyzer` | 自動跳過 |
