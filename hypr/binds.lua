local main_mod = 'SUPER'

hl.bind(main_mod .. ' + Q', hl.dsp.exec_cmd('uwsm app -- $TERMINAL'))
hl.bind(main_mod .. ' + C', hl.dsp.window.close())
hl.bind(main_mod .. ' + M', hl.dsp.exec_cmd('uwsm stop'))
hl.bind(main_mod .. ' + E', hl.dsp.exec_cmd('uwsm app -- $LOCK'))
hl.bind(main_mod .. ' + V', hl.dsp.window.float({ action = 'toggle' }))
hl.bind(main_mod .. ' + R', hl.dsp.exec_cmd('uwsm app -- $LAUNCHER'))
hl.bind(main_mod .. ' + B', hl.dsp.exec_cmd('uwsm app -- $BROWSER'))
hl.bind(main_mod .. ' + F', hl.dsp.window.fullscreen({ action = 'toggle' }))

-- Vim nav bindings
hl.bind(main_mod .. ' + H', hl.dsp.focus({ direction = 'l' }))
hl.bind(main_mod .. ' + L', hl.dsp.focus({ direction = 'r' }))
hl.bind(main_mod .. ' + K', hl.dsp.focus({ direction = 'u' }))
hl.bind(main_mod .. ' + J', hl.dsp.focus({ direction = 'd' }))

hl.bind(main_mod .. ' + SHIFT + H', hl.dsp.window.move({ direction = 'l' }))
hl.bind(main_mod .. ' + SHIFT + L', hl.dsp.window.move({ direction = 'r' }))
hl.bind(main_mod .. ' + SHIFT + K', hl.dsp.window.move({ direction = 'u' }))
hl.bind(main_mod .. ' + SHIFT + J', hl.dsp.window.move({ direction = 'd' }))

-- Workspace binding (mod used to map 10 -> 0)
for workspace = 1, 10 do
  local key = workspace % 10
  hl.bind(main_mod .. ' + ' .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(main_mod .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. ' + right', hl.dsp.focus({ workspace = 'e+1' }))
hl.bind(main_mod .. ' + left', hl.dsp.focus({ workspace = 'e-1' }))

-- Mouse bindings
hl.bind(main_mod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })
hl.bind(main_mod .. ' + mouse_down', hl.dsp.focus({ workspace = 'e+1' }))
hl.bind(main_mod .. ' + mouse_up', hl.dsp.focus({ workspace = 'e-1' }))

-- Media bindings
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+'))
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-'))

hl.bind('XF86AudioPlay', hl.dsp.exec_cmd('playerctl play'))
hl.bind('XF86AudioPause', hl.dsp.exec_cmd('playerctl pause'))
hl.bind('XF86AudioNext', hl.dsp.exec_cmd('playerctl next'))
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd('playerctl previous'))

-- Emergency DPMS binding
hl.bind(main_mod .. '+ SHIFT + XF86MonBrightnessUp', hl.dsp.dpms(), { locked = true })
