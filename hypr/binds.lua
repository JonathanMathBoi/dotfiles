local mod = require('config').mod

hl.bind(mod .. ' + Q', hl.dsp.exec_cmd('uwsm app -- $TERMINAL'))
hl.bind(mod .. ' + C', hl.dsp.window.close())
hl.bind(mod .. ' + M', hl.dsp.exec_cmd('uwsm stop'))
hl.bind(mod .. ' + E', hl.dsp.exec_cmd('uwsm app -- $LOCK'))
hl.bind(mod .. ' + V', hl.dsp.window.float({ action = 'toggle' }))
hl.bind(mod .. ' + R', hl.dsp.exec_cmd('uwsm app -- $LAUNCHER'))
hl.bind(mod .. ' + B', hl.dsp.exec_cmd('uwsm app -- $BROWSER'))
hl.bind(mod .. ' + F', hl.dsp.window.fullscreen({ action = 'toggle', layout_aware = true }))

-- Vim nav bindings
hl.bind(mod .. ' + H', hl.dsp.focus({ direction = 'l' }))
hl.bind(mod .. ' + L', hl.dsp.focus({ direction = 'r' }))
hl.bind(mod .. ' + K', hl.dsp.focus({ direction = 'u' }))
hl.bind(mod .. ' + J', hl.dsp.focus({ direction = 'd' }))

hl.bind(mod .. ' + SHIFT + H', hl.dsp.window.move({ direction = 'l' }))
hl.bind(mod .. ' + SHIFT + L', hl.dsp.window.move({ direction = 'r' }))
hl.bind(mod .. ' + SHIFT + K', hl.dsp.window.move({ direction = 'u' }))
hl.bind(mod .. ' + SHIFT + J', hl.dsp.window.move({ direction = 'd' }))

-- Workspace binding (mod used to map 10 -> 0)
for workspace = 1, 10 do
  local key = workspace % 10
  hl.bind(mod .. ' + ' .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(mod .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(mod .. ' + right', hl.dsp.focus({ workspace = 'e+1' }))
hl.bind(mod .. ' + left', hl.dsp.focus({ workspace = 'e-1' }))

-- Mouse bindings
hl.bind(mod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. ' + mouse_down', hl.dsp.focus({ workspace = 'e+1' }))
hl.bind(mod .. ' + mouse_up', hl.dsp.focus({ workspace = 'e-1' }))

-- Media bindings
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+'))
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-'))

hl.bind('XF86AudioPlay', hl.dsp.exec_cmd('playerctl play'))
hl.bind('XF86AudioPause', hl.dsp.exec_cmd('playerctl pause'))
hl.bind('XF86AudioNext', hl.dsp.exec_cmd('playerctl next'))
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd('playerctl previous'))

-- Emergency DPMS binding
hl.bind(mod .. '+ SHIFT + XF86MonBrightnessUp', hl.dsp.dpms(), { locked = true })

-- Auto-rotate toggle
hl.bind(mod .. ' + minus', function()
  require('autorotate').toggle()
end)
