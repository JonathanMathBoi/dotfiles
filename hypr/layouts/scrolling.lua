-- General Config
hl.config({
  general = { layout = 'scrolling' },
  scrolling = {
    direction = 'right',
    wrap_swapcol = false,
    column_width = 0.8,
  },
})

-- Binding Configurations
-- TODO: Fine a way to unify with binding configs
local mod = require('config').mod

-- Swap columns left and right
hl.bind(mod .. ' + bracketleft', hl.dsp.layout('swapcol l'))
hl.bind(mod .. ' + bracketright', hl.dsp.layout('swapcol r'))

-- Shrink and expand columns
hl.bind(mod .. ' + SHIFT + bracketleft', hl.dsp.layout('colresize -0.2'))
hl.bind(mod .. ' + SHIFT + bracketright', hl.dsp.layout('colresize +0.2'))

-- Compress and expand behavior
-- If window is alone in column, compress into
-- If window is not alone, expand out of
hl.bind(mod .. ' + COMMA', hl.dsp.layout('consume_or_expel next'))

-- Cycle column widths
hl.bind(mod .. ' + T', hl.dsp.layout('colresize +conf'))

-- Gestures Configuration
hl.gesture({
  fingers = 3,
  direction = 'horizontal',
  action = 'scroll_move',
  -- TODO: Update gesture handling to make activation curve smooth
  scale = 1.5,
})
