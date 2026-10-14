function fish_user_key_bindings
    # 接住 kitty 送來的 control code，讓同一顆鍵在 shell 和 nvim 裡是同一個動作。
    # 對接處：~/.config/kitty/keys-macos.conf、keys-linux.conf 的 map ... send_text
    #         ~/.config/nvim/lua/config/keymaps.lua

    bind ctrl-_ undo               # cmd+z
    bind ctrl-^ redo               # cmd+shift+z
    bind "ctrl-]" fish_clipboard_copy  # cmd+c
end
