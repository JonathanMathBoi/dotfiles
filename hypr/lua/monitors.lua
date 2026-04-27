local function read_hostname()
  local handle = io.popen('hostname')
  if handle == nil then
    return nil
  end

  local name = handle:read('*l')
  handle:close()
  return name
end

local hostname = read_hostname() or os.getenv('HOSTNAME') or 'unknown'

if hostname == 'forest' then
  hl.monitor({
    output = 'DP-5',
    mode = '3440x1440@144',
    position = '0x0',
    scale = 1,
    vrr = 0,
  })
  hl.monitor({
    output = 'DP-3',
    mode = '2560x1440@100',
    position = '3440x0',
    scale = 1,
  })
  return
end

if hostname == 'meadow' then
  hl.monitor({
    output = 'eDP-1',
    mode = '1920x1200@60',
    position = '0x0',
    scale = 1.07,
  })
  return
end

hl.monitor({
  output = '',
  mode = 'preferred',
  position = 'auto',
  scale = 1,
})
