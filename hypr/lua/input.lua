hl.config({
  input = {
    kb_layout = 'us',

    -- Makes caps lock act as escape
    kb_options = 'caps:escape',

    -- Follow mouse is default, but set for clarity
    follow_mouse = 1,

    -- Modifies mouse sensitivity
    -- Usually leave this for the mouse to handle
    sensitivity = 0,

    touchpad = {
      -- Two-finger scroll mirrors touch interaction
      -- Move fingers up to pull up (scroll down)
      -- Move fingers down to pull down (scroll up)
      natural_scroll = true,
    },
  },
})
