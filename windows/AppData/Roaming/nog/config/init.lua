local direction_keys = {
  h = "left",
  j = "down",
  k = "up",
  l = "right"
}

local workspaces = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }

nog.config.bar.font_size = 10
nog.config.bar.color = 0x646235
nog.config.bar.height = 13
nog.config.bar.components = {
  left = { nog.components.workspaces() },
  center = { nog.components.current_window() },
  right = {
    nog.components.datetime("%a   %b %e   %I:%M %p"),
    nog.components.padding(1),
  },
}

nog.config.work_mode = true
nog.config.display_app_bar = true
nog.config.launch_on_startup = false
nog.config.multi_monitor = false
nog.config.remove_task_bar = false
nog.config.use_border = false
nog.config.remove_title_bar = false

nog.config.rules = {
  ["snippingtool.exe"] = { 
    action = "ignore"
  },
  ["dual-key-remap"] = {
    action = "ignore"
  },
  ["Microsoft Teams Notification"] = {
    action = "ignore"
  },
  ["Color Picker"] = {
    action = "ignore"
  },
  ["msiexec.exe"] = {
    action = "ignore"
  },
}

local leader = "control+alt"

nog.nbind(leader .. "+i", nog.win_ignore)
nog.nbind(leader .. "+shift+c", nog.win_close)
nog.nbind(leader .. "+x", nog.quit)
nog.nbind(leader .. "+f", nog.win_toggle_floating)
nog.gbind(leader .. "+w", nog.toggle_work_mode)

nog.nbind_tbl(leader, nog.ws_focus, direction_keys)
nog.nbind_tbl(leader .. "+shift", nog.ws_swap, direction_keys)
nog.nbind_tbl(leader, nog.ws_change, workspaces)
nog.nbind_tbl(leader .. "+shift", nog.win_move_to_ws, workspaces)

-- nog.nbind("control+alt+f", nog.ws_toggle_fullscreen)
-- nog.nbind_tbl("alt+control", nog.ws_move_to_monitor, workspaces)
-- nog.nbind(leader .. "+v", function() nog.ws_set_split_direction("Vertical") end)
-- nog.nbind(leader .. "+b", function() nog.ws_set_split_direction("Horizontal") end)
-- nog.nbind(leader .. "+m", nog.win_minimize)