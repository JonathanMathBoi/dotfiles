require('monitors')
require('gestures')
require('binds')
require('submaps.screenshot')
require('layout')
require('input')
require('animations')
require('decoration')
require('theme')

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})

-- FIX: Add iio display rotation functionality via Lua
-- The Lua update broke iio-hyprland, and Lua can achieve the same effect
