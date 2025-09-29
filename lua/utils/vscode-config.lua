local M = {}

local function get_project_root()
  -- Use built-in root detection instead of lspconfig.util
  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.fnamemodify(current_file, ":h")

  -- Look for .git or .vscode directories going up the directory tree
  local function find_root_dir(dir)
    if dir == "" or dir == "/" then
      return vim.fn.getcwd()
    end

    local git_dir = dir .. "/.git"
    local vscode_dir = dir .. "/.vscode"

    if vim.fn.isdirectory(git_dir) == 1 or vim.fn.isdirectory(vscode_dir) == 1 then
      return dir
    end

    local parent_dir = vim.fn.fnamemodify(dir, ":h")
    return find_root_dir(parent_dir)
  end

  return find_root_dir(current_dir)
end

function M.get_vscode_config()
  local root = get_project_root()
  local config_path = root .. "/.vscode/settings.json"

  if vim.fn.filereadable(config_path) == 1 then
    local ok, content = pcall(vim.fn.readfile, config_path)
    if ok and content and #content > 0 then
      local json = table.concat(content, "\n")
      if json and json:match("%S") then  -- Pastikan string tidak kosong atau hanya whitespace
        local success, decoded = pcall(vim.fn.json_decode, json)
        if success and type(decoded) == "table" then
          return decoded
        end
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
