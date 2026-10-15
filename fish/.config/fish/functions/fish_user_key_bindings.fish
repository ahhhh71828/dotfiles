function fish_user_key_bindings
    # 接住 kitty 送來的 control code，讓同一顆鍵在 shell 和 nvim 裡是同一個動作。
    # 對接處：~/.config/kitty/keys-macos.conf、keys-linux.conf 的 map ... send_text
    #         ~/.config/nvim/lua/config/keymaps.lua
    # 用 \x 寫法而不是 ctrl-_：ctrl-_ 是 fish 4 才有的寫法，\x 在 fish 3 和 4 都能用。

    bind \x1f undo                 # cmd+z（ctrl-_）
    bind \x1e redo                 # cmd+shift+z（ctrl-^）
    bind \x1d fish_clipboard_copy  # cmd+c（ctrl-]）
end
