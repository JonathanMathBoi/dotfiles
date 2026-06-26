local M = {}

local _initialized = false

-- BUG: iio:devices change numbers on boot
-- Update to handle dynamically
local ACCEL_PATH = '/sys/bus/iio/devices/iio:device0'
local MONITOR = 'eDP-1'
local POLL_INTERVAL = 1000

local function read_accel()
  local x_file = io.open(ACCEL_PATH .. '/in_accel_x_raw', 'r')
  local y_file = io.open(ACCEL_PATH .. '/in_accel_y_raw', 'r')
  local z_file = io.open(ACCEL_PATH .. '/in_accel_z_raw', 'r')
  local scale_file = io.open(ACCEL_PATH .. '/scale', 'r')

  if not x_file or not y_file or not z_file or not scale_file then
    if x_file then
      x_file:close()
    end
    if y_file then
      y_file:close()
    end
    if z_file then
      z_file:close()
    end
    if scale_file then
      scale_file:close()
    end
    return nil
  end

  local x = tonumber(x_file:read('*l'))
  local y = tonumber(y_file:read('*l'))
  local z = tonumber(z_file:read('*l'))
  local scale = tonumber(scale_file:read('*l'))

  x_file:close()
  y_file:close()
  z_file:close()
  scale_file:close()

  if not x or not y or not z or not scale then
    return nil
  end

  return {
    x = x * scale,
    y = y * scale,
    z = z * scale,
  }
end

local function get_orientation(accel)
  local abs_x = math.abs(accel.x)
  local abs_y = math.abs(accel.y)
  local abs_z = math.abs(accel.z)

  if abs_z > abs_x and abs_z > abs_y then
    return nil
  end

  if abs_x > abs_y then
    if accel.x > 0 then
      return 3
    else
      return 1
    end
  else
    if accel.y > 0 then
      return 0
    else
      return 2
    end
  end
end

local current_transform = -1
local timer_handle = nil

function M.start()
  if not _initialized then
    return
  end
  if timer_handle then
    if timer_handle.is_enabled and not timer_handle:is_enabled() then
      timer_handle:set_enabled(true)
    end
    return
  end

  local function check_orientation()
    local accel = read_accel()
    if not accel then
      return
    end

    local transform = get_orientation(accel)
    if transform and transform ~= current_transform then
      current_transform = transform

      hl.monitor({
        output = MONITOR,
        transform = transform,
      })

      hl.config({ input = { touchdevice = { transform = transform }, tablet = { transform = transform } } })
    end
  end

  timer_handle = hl.timer(check_orientation, { timeout = POLL_INTERVAL, type = 'repeat' })
  check_orientation()
end

function M.stop()
  if not _initialized then
    return
  end
  if timer_handle and timer_handle.set_enabled then
    timer_handle:set_enabled(false)
  end
end

function M.toggle()
  if not _initialized then
    return
  end
  if timer_handle and timer_handle.is_enabled then
    local enabled = timer_handle:is_enabled()
    timer_handle:set_enabled(not enabled)
  elseif timer_handle then
    M.stop()
  else
    M.start()
  end
end

function M.setup()
  if _initialized then
    return
  end
  _initialized = true

  hl.on('hyprland.start', function()
    M.start()
  end)

  hl.on('config.reloaded', function()
    if timer_handle then
      timer_handle:set_enabled(false)
      timer_handle = nil
    end
    M.start()
  end)

  M.start()
end

return M
