rex.bind("ctrl+x>ctrl+x", "pane.send_key", { key = "ctrl+x" })
rex.bind("ctrl+x>shift+\\", "pane.split", { direction = "right" })
rex.bind("ctrl+x>-", "pane.split", { direction = "down" })
rex.bind("ctrl+x>r", "client.config.reload")
rex.bind("shift+left", "client.tab.previous")
rex.bind("shift+right", "client.tab.next")

-- nvim handles ctrl+hjkl itself and calls `rex focus` when it is at its edge window.
for key, direction in pairs{ h = "left", j = "down", k = "up", l = "right" } do
  rex.bind("ctrl+" .. key, function(ctx)
    local p = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
    if p and p.foreground and p.foreground.name == "nvim" then return false end
    rex.session.focus_direction{ direction = direction }
    return true
  end)
end

rex.action{
  name  = "scrollback_nvim",
  title = "Open Scrollback in Nvim",
  run   = function(ctx)
    local _, err = rex.session.new_layer{
      bounds = { 0.05, 0.05, 0.9, 0.9 },
      focus  = true,
      layout = rex.layout.block{
        flavor  = "com.superlogical.terminal.shell",
        options = {
          command = { "sh", "-c", 'rex capture -b "$1" --unwrap | nvim -', "sh", ctx.block_id },
        },
      },
    }
    if err ~= nil then error(err, 0) end
  end,
}
rex.bind("ctrl+x>[", "scrollback_nvim")

rex.bind("cmd+n", "session.new")
rex.bind("shift+cmd+n", "client.window.new")
