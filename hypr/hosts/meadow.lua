hl.monitor({
  output = 'eDP-1',
  mode = '1920x1200@60',
  position = '0x0',
  scale = 1.07,
})

hl.config({
  input = {
    touchpad = {
      -- BUG: FW12 touchpad y-axis motion is inverted for some reason
      -- Remove this when it's fixed and randomly is broken again (because it got fixed)
      flip_y = true,
    },
  },
})
