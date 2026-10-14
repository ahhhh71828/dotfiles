# Homebrew (macOS)
if test (uname) = Darwin
    if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv fish)
    end
end

# uv-managed Python interpreters
fish_add_path -g ~/.local/bin

# Starship
set -gx STARSHIP_CONFIG ~/.config/starship.toml

if type -q starship
    starship init fish | source
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/ahh/.lmstudio/bin
# End of LM Studio CLI section

# DICLAB remote desktops
function gui88
    open -a '/Applications/Windows App.app' ~/.config/diclab/lab88.rdp
end

function gui89
    open -a '/Applications/Windows App.app' ~/.config/diclab/lab89.rdp
end
