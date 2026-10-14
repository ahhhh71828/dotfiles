function claude --description 'Run Claude Code with the personal account'
    # Shield this process from a stale OAuth token inherited by an older shell.
    set --local --unexport CLAUDE_CODE_OAUTH_TOKEN
    command claude $argv
end
