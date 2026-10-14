function claude-max --description 'Run Claude Code with the separate Max OAuth token'
    if not set -q CLAUDE_FRIEND_OAUTH_TOKEN; or test -z "$CLAUDE_FRIEND_OAUTH_TOKEN"
        echo 'claude-max: 找不到朋友的 Claude OAuth token；已停止，沒有改用其他帳號。' >&2
        return 1
    end

    set -lx CLAUDE_CODE_OAUTH_TOKEN "$CLAUDE_FRIEND_OAUTH_TOKEN"
    command claude $argv
end
