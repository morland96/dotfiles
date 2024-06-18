local Process = require("lazy.manage.process")

M = {}

function M.get_remote(repo)
  local lines = Process.exec({"git", "remote", "get-url", "origin"}, {cwd = repo})
  return lines[1] or ""
end

return M
