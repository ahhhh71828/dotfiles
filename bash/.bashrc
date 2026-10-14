# bash 設定：外觀與 fish 一致（提示列、檔案顏色、打字顏色、快捷鍵）。
# 實際檔案在 ~/dotfiles/bash/，由 `cd ~/dotfiles && stow bash shell` 連到家目錄。
#
# 新電腦需要另外安裝（沒裝時對應功能會自動跳過）：
#   starship  提示列，設定共用 ~/.config/starship.toml
#   eza       ls 改用 eza
#   ble.sh    打字顏色與快捷鍵，設定在 ~/.config/blesh/init.sh
#     curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
#     bash ble-nightly/ble.sh --install ~/.local/share
#   macOS 另外要 `brew install bash`，系統內建的 bash 3.2 跑 ble.sh 太慢。

# 只有互動模式才套用，跑 script 時不載入
[[ $- == *i* ]] || return

# ble.sh 要最先載入，最後才 ble-attach；bash 4 以上才用
if ((BASH_VERSINFO[0] >= 4)) && [[ -f ~/.local/share/blesh/ble.sh ]]; then
  source ~/.local/share/blesh/ble.sh --noattach
fi

# Homebrew（macOS、Linuxbrew）
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv bash)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
fi

# uv-managed Python interpreters
[[ :$PATH: == *:$HOME/.local/bin:* ]] || PATH=$HOME/.local/bin:$PATH

# eza / ls 檔案顏色，與 fish 共用
[[ -f ~/.config/shell/colors.sh ]] && source ~/.config/shell/colors.sh

# ls / ll / la，與 fish 的 functions/ls.fish、ll.fish、la.fish 相同
if command -v eza &>/dev/null; then
  ls() { eza --icons --group-directories-first "$@"; }
  ll() { eza -lah --icons --group-directories-first "$@"; }
  la() { eza -a --icons --group-directories-first "$@"; }
else
  ll() { command ls -lah "$@"; }
  la() { command ls -a "$@"; }
fi

# Starship
export STARSHIP_CONFIG=~/.config/starship.toml
command -v starship &>/dev/null && eval "$(starship init bash)"

[[ ${BLE_VERSION-} ]] && ble-attach
. "$HOME/.cargo/env"
