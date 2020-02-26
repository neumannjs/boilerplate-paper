-- file: git-revision.lua
-- improve this by checking for unstaged or staged changes OR maybe committing them?

function Meta(m)
  local handle = io.popen("git describe --always --tags","r")
  local result = handle:read("*a")
  handle:close()
  local revision = result
  local uncommitted_changes = false

  handle = io.popen("git diff HEAD --name-only","r")
  result = handle:read("*a")
  if string.len(result) > 0 then uncommitted_changes = true end
  
  handle = io.popen("git ls-files --exclude-standard --others","r")
  result = handle:read("*a")
  if string.len(result) > 0 then uncommitted_changes = true end

  if uncommitted_changes then revision = revision .. " (uncommitted changes!)" end
  
  m.revision = revision

  handle = io.popen("git log -1 --format=\"%ad\" --date=short","r")
  result = handle:read("*a")
  m.date = result
  return m
end