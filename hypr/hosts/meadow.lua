hl.monitor({
  output = 'eDP-1',
  mode = '1920x1200@60',
  position = '0x0',
  scale = 1.0,
})

require('layouts.scrolling')
hl.config({
  scrolling = {
    explicit_column_widths = '0.5, 0.8, 1.0',
  },
})

require('autorotate').setup()
