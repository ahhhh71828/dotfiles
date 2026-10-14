function la --wraps eza
    if command -q eza
        eza -a --icons --group-directories-first $argv
    else
        command ls -a $argv
    end
end
