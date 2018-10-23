def volume_fade
  set = `osascript -e 'output volume of (get volume settings)'`.to_i
  volume = set
  while true do
    `osascript -e 'set volume output volume #{volume}'`
    volume -= 2
    sleep(0.01)
    break if volume <= 0
  end
  sleep(0.5)
end

def volume_fade_quick
   set = `osascript -e 'output volume of (get volume settings)'`.to_i
   volume = set
  while true do
    `osascript -e 'set volume output volume #{volume}'`
    volume -= 5
    sleep(0.01)
    break if volume <= 0
  end
  sleep(0.5)
end

def volume_fade_up
  volume = 0
  while true do
    `osascript -e 'set volume output volume #{volume}'`
    volume += 1
    sleep(0.01)
    break if volume == 50
  end
end

def volume_fade_up_quick
  volume = 0
  while true do
    `osascript -e 'set volume output volume #{volume}'`
    volume += 5
    sleep(0.01)
    break if volume == 50
  end
end
