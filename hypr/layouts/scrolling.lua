-- General Config
hl.config({
  general = { layout = 'scrolling' },
  scrolling = {
    direction = 'right',
    column_width = 0.8,
    widths = { 0.5, 0.8, 1.0 },
  },
})

-- Binding Configurations
-- TODO: Fine a way to unify with binding configs
local main_mod = 'SUPER'

-- Swap columns left and right
hl.bind(main_mod .. ' + bracketleft', hl.dsp.layout('swapcol l'))
hl.bind(main_mod .. ' + bracketright', hl.dsp.layout('swapcol r'))

-- Compress and expand behavior
-- If window is alone in column, compress into
-- If window is not alone, expand out of
hl.bind(main_mod .. ' + COMMA', hl.dsp.layout('consume_or_expel next'))

-- Cycle column widths
hl.bind(main_mod .. ' + T', hl.dsp.layout('colresize +conf'))

-- Gestures Configuration
hl.gesture({
  fingers = 3,
  direction = 'horizontal',
  action = 'scroll_move',
  -- TODO: Update gesture handling to make activation curve smooth
  scale = 1.5,
})
