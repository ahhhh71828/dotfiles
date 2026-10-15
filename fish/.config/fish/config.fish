# Homebrew（macOS、Linuxbrew）
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv fish)
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)
end

# uv-managed Python interpreters
fish_add_path -g ~/.local/bin

# Starship
set -gx STARSHIP_CONFIG ~/.config/starship.toml

if type -q starship
    starship init fish | source
end
