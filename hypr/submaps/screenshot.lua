hl.bind('SUPER + S', hl.dsp.submap('screenshot'))

hl.define_submap('screenshot', function()
  -- Fullscreen screenshot
  hl.bind('f', function()
    hl.dispatch(hl.dsp.exec_cmd('grimblast copysave screen "$HOME/pictures/screenshots/full/"$(date +\'%F-%T.png\')'))
    hl.dispatch(hl.dsp.submap('reset'))
  end)

  -- Selction (area) screenshot
  hl.bind('s', function()
    hl.dispatch(hl.dsp.exec_cmd('grimblast copysave area "$HOME/pictures/screenshots/area/"$(date +\'%F-%T.png\')'))
    hl.dispatch(hl.dsp.submap('reset'))
  end)

  -- Active window screenshot
  hl.bind('a', function()
    hl.dispatch(hl.dsp.exec_cmd('grimblast copysave active "$HOME/pictures/screenshots/active/"$(date +\'%F-%T.png\')'))
    hl.dispatch(hl.dsp.submap('reset'))
  end)

  hl.bind('escape', hl.dsp.submap('reset'))
  hl.bind('catchall', hl.dsp.submap('reset'))
end)
