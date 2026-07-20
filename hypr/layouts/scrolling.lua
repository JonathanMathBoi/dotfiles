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

hl.bind(main_mod .. ' + T', hl.dsp.layout('colresize +conf'))
