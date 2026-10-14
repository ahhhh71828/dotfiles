function ll --wraps eza
    if command -q eza
        eza -lah --icons --group-directories-first $argv
    else
        command ls -lah $argv
    end
end
