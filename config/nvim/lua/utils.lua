local M = {}

function M.dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

M.usePlugin = function(name)
  local status, plugin = pcall(require, name)
  if not status then
    return false
  end
  return plugin
end


M.setIndent = function(tabLength, useHardTab)
  if useHardTab then
    vim.bo.expandtab = false
  else
    vim.bo.expandtab = true
  end

  vim.bo.shiftwidth  = tabLength
  vim.bo.softtabstop = tabLength
  vim.bo.tabstop     = tabLength
end

return M
