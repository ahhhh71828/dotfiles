local packages = {
  "bash-language-server",
  "json-lsp",
  "lua-language-server",
  "marksman",
  "pyright",
  "ruff",
  "taplo",
  "vtsls",
  "yaml-language-server",
}

require("lazy").load({ plugins = { "mason.nvim" } })

local registry = require("mason-registry")
registry.refresh()

local pending = 0
local failed = {}

for _, name in ipairs(packages) do
  local ok, pkg = pcall(registry.get_package, name)
  if not ok then
    table.insert(failed, name .. ": package not found")
  elseif not pkg:is_installed() and not pkg:is_installing() then
    pending = pending + 1
    pkg:install({}, function(success, err)
      if not success then
        table.insert(failed, name .. ": " .. tostring(err))
      end
      pending = pending - 1
    end)
  end
end

vim.wait(900000, function()
  return pending == 0
end, 100)

if #failed > 0 then
  error(table.concat(failed, "\n"))
end
