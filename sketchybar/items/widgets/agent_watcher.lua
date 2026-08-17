local settings = require("config.settings")

-- Full path: sketchybar runs scripts with a minimal PATH, so ~/.cargo/bin is
-- not resolved from a bare `agent-watcher`.
local AGENT_WATCHER = os.getenv("HOME") .. "/.cargo/bin/agent-watcher"

-- `agent-watcher status --content` prints "▶2 ⏸1 ⚠1" (working / idle / waiting
-- counts) via a sub-millisecond socket round-trip, and an EMPTY string when
-- there are no sessions. We drop the built-in "CC" label and render a generic
-- agent icon (the Nerd Font robot glyph) in front of the counts instead. The
-- status query never auto-spawns the daemon, so this widget draws only while
-- agent sessions are live and hides itself otherwise.
local agent_watcher = sbar.add("item", "widgets.agent_watcher", {
  position = "right",
  update_freq = 2, -- matches the tmux status-interval
  -- Poll even while hidden. The default `when_shown` stops routine ticks once
  -- the item hides itself (empty counts), so it could never reappear when
  -- sessions came back without a full sketchybar reload. `always` keeps the
  -- 2s tick running while drawing = false so the widget self-heals.
  updates = true,
  label = {
    color = settings.colors.dirty_white,
    padding_left = 0,
    padding_right = settings.dimens.padding.label,
  },
})

agent_watcher:subscribe({ "routine", "system_woke", "forced" }, function()
  sbar.exec("'" .. AGENT_WATCHER .. "' status --content 2>/dev/null", function(out)
    local counts = (out or ""):gsub("%s+$", "")
    if counts == "" then
      agent_watcher:set({ drawing = false })
      return
    end
    -- Light the whole widget red when a session is waiting for input (the ⚠
    -- glyph is present) so the alert reads at a glance.
    local color = counts:find("⚠") and settings.colors.red or settings.colors.dirty_white
    agent_watcher:set({
      drawing = true,
      icon = { color = color },
      label = { string = counts, color = color },
    })
  end)
end)
