# Fish syntax colors
# bash（ble.sh）用同一組顏色，改這裡時也要改 ~/.config/blesh/init.sh
set -g fish_color_normal CDD6F4
set -g fish_color_command 89B4FA --bold
set -g fish_color_keyword F5A6D6 --bold
set -g fish_color_param A6ADC8
set -g fish_color_option F5C2E7
set -g fish_color_quote F9E2AF
set -g fish_color_operator FAB387
set -g fish_color_redirection FAB387
set -g fish_color_comment 6C7086
set -g fish_color_error FF5C7A --bold
set -g fish_color_cancel FF5C7A --bold
set -g fish_color_autosuggestion 45475A
set -g fish_color_valid_path 94E2D5 --underline

# eza / ls 檔案顏色：與 bash 共用，改顏色請改這個檔案
# ~/dotfiles/shell/.config/shell/colors.sh
if test -f ~/.config/shell/colors.sh
    source ~/.config/shell/colors.sh
end
