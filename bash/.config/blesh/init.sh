# ble.sh 設定：bash 打字時的顏色與快捷鍵。
# 由 ~/.bashrc 載入的 ble.sh 自動讀取這個檔案。

# ---------------------------------------------------------------------------
# 打字顏色：照 fish 的 fish_color_* 逐項對應。
# 對接處：~/.config/fish/conf.d/theme.fish，改那邊的顏色時這裡也要改。
# 兩邊寫法不同，無法共用同一份檔案。
# ---------------------------------------------------------------------------

# fish_color_param A6ADC8：一般參數
ble-face -s syntax_default         fg=#A6ADC8

# fish_color_command 89B4FA --bold：指令名稱
ble-face -s command_file           fg=#89B4FA,bold
ble-face -s command_builtin        fg=#89B4FA,bold
ble-face -s command_builtin_dot    fg=#89B4FA,bold
ble-face -s command_alias          fg=#89B4FA,bold
ble-face -s command_function       fg=#89B4FA,bold
ble-face -s command_jobs           fg=#89B4FA,bold
ble-face -s command_directory      fg=#89B4FA,bold,underline

# fish_color_keyword F5A6D6 --bold：if、for、while 等
ble-face -s command_keyword        fg=#F5A6D6,bold

# fish_color_option F5C2E7：-l、--help 等選項
ble-face -s argument_option        fg=#F5C2E7

# fish_color_quote F9E2AF：引號字串
ble-face -s syntax_quoted          fg=#F9E2AF
ble-face -s syntax_quotation       fg=#F9E2AF

# | ; && 在 fish 是預設的綠色（theme.fish 沒設 fish_color_end）。
# ble.sh 的 > 也用同一個顏色，無法像 fish 一樣單獨設成橘色。
ble-face -s syntax_delimiter       fg=green

# fish_color_operator FAB387：$變數 * ~ 等
ble-face -s syntax_param_expansion fg=#FAB387
ble-face -s syntax_varname         fg=#FAB387
ble-face -s syntax_glob            fg=#FAB387
ble-face -s syntax_brace           fg=#FAB387
ble-face -s syntax_tilde           fg=#FAB387

# fish_color_comment 6C7086：# 註解
ble-face -s syntax_comment         fg=#6C7086

# fish_color_error FF5C7A --bold：打錯的指令、語法錯誤
ble-face -s syntax_error           fg=#FF5C7A,bold
ble-face -s argument_error         fg=#FF5C7A,bold

# fish_color_autosuggestion 45475A：灰色的自動建議
ble-face -s auto_complete          fg=#45475A

# fish_color_valid_path 94E2D5 --underline：存在的檔案路徑
ble-face -s filename_directory     fg=#94E2D5,underline
ble-face -s filename_other         fg=#94E2D5,underline
ble-face -s filename_executable    fg=#94E2D5,underline
ble-face -s filename_link          fg=#94E2D5,underline

# 指令失敗或跑很久時，ble.sh 會多印一行 [ble: exit 127] 之類的提示；fish 沒有，關掉
bleopt exec_errexit_mark=
bleopt exec_elapsed_mark=

# ---------------------------------------------------------------------------
# 快捷鍵：接住終端機送來的 control code，讓同一顆鍵在 bash、fish、nvim 裡
# 是同一個動作。
# 對接處：~/.config/kitty/keys-macos.conf、keys-linux.conf 的 map ... send_text
#         ~/.config/fish/functions/fish_user_key_bindings.fish
#         ~/.config/nvim/lua/config/keymaps.lua
# ---------------------------------------------------------------------------

# 複製到系統剪貼簿：有選取就複製選取，沒選取就複製整行指令（同 fish）。
function ble/widget/dotfiles/copy-to-clipboard {
  local text=$_ble_edit_str
  if [[ $_ble_edit_mark_active ]]; then
    local a=$_ble_edit_mark b=$_ble_edit_ind
    ((a > b)) && { local t=$a; a=$b; b=$t; }
    text=${_ble_edit_str:a:b-a}
  fi
  if type pbcopy &>/dev/null; then
    printf '%s' "$text" | pbcopy
  elif [[ $WAYLAND_DISPLAY ]] && type wl-copy &>/dev/null; then
    printf '%s' "$text" | wl-copy
  elif type xclip &>/dev/null; then
    printf '%s' "$text" | xclip -selection clipboard
  elif type clip.exe &>/dev/null; then
    printf '%s' "$text" | clip.exe
  fi
  _ble_edit_mark_active=
}

function blerc/dotfiles/keybindings {
  ble-bind -f 'C-_' emacs/undo                   # cmd+z
  ble-bind -f 'C-^' emacs/redo                   # cmd+shift+z
  ble-bind -f 'C-]' dotfiles/copy-to-clipboard   # cmd+c
}
blehook/eval-after-load keymap_emacs blerc/dotfiles/keybindings
