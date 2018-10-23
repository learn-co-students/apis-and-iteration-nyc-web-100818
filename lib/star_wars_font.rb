require 'pastel'
require 'tty-cursor'
require 'tty-screen'
require 'tty-font'

# require_relative '../lib/tty-font'

@pastel   = Pastel.new
@cursor   = TTY::Cursor
@font     = TTY::Font.new(:starwars)
@reg_font = TTY::Font.new(:straight)

@size = TTY::Screen.size

def lines_at(lines, x, y)
  lines.each_with_index.reduce([]) do |acc, (line, i)|
    acc << @cursor.move_to(x - line.size/2, y - lines.size/2 + i) + line
    acc
  end
end

def paint_logo(title)
  print @cursor.save
  print @cursor.clear_screen
  print @cursor.hide
  stars = ['.', '*']
  (@size[1] + @size[0]).times do |i|
    print @cursor.move_to(rand(@size[1]), rand(@size[0])) + stars[rand(2)]
  end

  center_x = @size[1]/2
  center_y = @size[0]/2

  lines = @font.write('STAR').split("\n")
  print @pastel.red(lines_at(lines, center_x, center_y - 5).join)
  lines = @reg_font.write(title, letter_spacing: 1).split("\n")
  print lines_at(lines, center_x, center_y).join
  lines = @font.write('WARS').split("\n")
  print @pastel.red(lines_at(lines, center_x, center_y + 4).join)
end

def print_star_wars_logo(title)
    paint_logo(title)
    sleep(2)
    puts "\n"
end

def reposition_cursor(y)
  print @cursor.move_to
  (@size[0]+10).times do
    print @cursor.clear_line
    print @cursor.down(1)
    sleep(0.12)
  end
  print @cursor.move_to(0, y)
end

def clear_screen
  print @cursor.move_to
    40.times do
      print @cursor.clear_line
      print @cursor.down(1)
      sleep(0.001)
  end
  print @cursor.move_to
end

def question_cursor
   print @cursor.move_to(0, (@size[1]-5/2))
end

def clear_screen
  print @cursor.move_to(10, 0)
    20.times do
      print @cursor.clear_line
      print @cursor.down(1)
      sleep(0.1)
  end
  # print @cursor.move_to(0, (@size[1] - word_height)/2)
  print @cursor.move_to(0, 5)
  sleep(0.5)
end

def clear_screen_quick
  print @cursor.move_to(0, 0)
    20.times do
      print @cursor.clear_line
      print @cursor.down(1)
      sleep(0.1)
  end
  print @cursor.move_to(0, 5)
end

def complete_screen_clear
  print @cursor.move_to(0, 0)
    100.times do
      print @cursor.clear_line
      print @cursor.down(1)
      sleep(0.01)
  end
  print @cursor.move_to(0, 5)
end

def instant_screen_clear
  print @cursor.move_to(0, 0)
    100.times do
      print @cursor.clear_line
      print @cursor.down(1)
  end
  print @cursor.move_to(0, 5)
end
