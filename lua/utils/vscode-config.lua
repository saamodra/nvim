local M = {}

local function get_project_root()
  local util = require("lspconfig.util")
  return util.root_pattern(".git", ".vscode")(vim.fn.expand("%:p")) or vim.fn.getcwd()
end

function M.get_vscode_config()
  local root = get_project_root()
  local config_path = root .. "/.vscode/settings.json"

  if vim.fn.filereadable(config_path) == 1 then
    local ok, content = pcall(vim.fn.readfile, config_path)
    if ok and content then
      local json = table.concat(content, "\n")
      local decoded = vim.fn.json_decode(json)
      if type(decoded) == "table" then
        return decoded
      end
    end
  end

  return {}
end

function M.is_enabled(key)
  local config = M.get_vscode_config()
  return config[key] == true
end

return M
