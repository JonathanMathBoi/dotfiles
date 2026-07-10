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
  return require('hosts.forest')
end

if hostname == 'meadow' then
  return require('hosts.meadow')
end

hl.monitor({
  output = '',
  mode = 'preferred',
  position = 'auto',
  scale = 1,
})
