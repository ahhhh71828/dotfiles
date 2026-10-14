function ls --wraps eza
    if command -q eza
        eza --icons --group-directories-first $argv
    else
        command ls $argv
    end
end
