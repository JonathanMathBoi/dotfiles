hl.window_rule({
  name = 'Xournal++ Scroll Width',
  -- Launch Xournal windows with full screen width on scrolling layout
  match = { class = 'com.github.xournalpp.xournalpp' },
  scrolling_width = 1.0,
})

hl.window_rule({
  name = 'Discord Scroll Width',
  -- Launch Discord with full screen width on scrolling layout
  match = { class = 'discord' },
  scrolling_width = 1.0,
})
