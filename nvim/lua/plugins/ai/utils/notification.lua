local M = {}

M.handles = {}
function M.init()
  -- CodeCompanion Progress
  local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanion*",
    group = group,
    callback = function(request)
      if request.match == "CodeCompanionChatSubmitted" then
        return
      end

      local msg

      msg = "[CodeCompanion] " .. request.match:gsub("CodeCompanion", "")

      vim.notify(msg, "info", {
        timeout = 1000,
        keep = function()
          return not vim
            .iter({ "Finished", "Opened", "Hidden", "Closed", "Cleared", "Created" })
            :fold(false, function(acc, cond)
              return acc or vim.endswith(request.match, cond)
            end)
        end,
        id = "code_companion_status",
        title = "Code Companion Status",
        opts = function(notif)
          notif.icon = ""
          if vim.endswith(request.match, "Started") then
            ---@diagnostic disable-next-line: undefined-field
            notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          elseif vim.endswith(request.match, "Finished") then
            notif.icon = " "
          end
        end,
      })
    end,
  })
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = group,
    callback = function(request)
      local msg

      if request.match == "CodeCompanionRequestStarted" then
        msg = "[CodeCompanion] starting..."
      elseif request.match == "CodeCompanionRequestStreaming" then
        msg = "[CodeCompanion] streaming..."
      else
        msg = "[CodeCompanion] finished"
      end

      vim.notify(msg, "info", {
        id = "code_companion_status",
        title = "Code Companion Status",
        opts = function(notif)
          notif.icon = request.match == "CodeCompanionRequestFinished" and " "
            ---@diagnostic disable-next-line: undefined-field
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end


return M
