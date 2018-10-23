require 'io/console'

def welcome
  instant_screen_clear
  pid = fork{ exec 'afplay', "force_theme.mp3" }
  volume_fade_up_quick
  clear_screen_quick
  our_star_wars_title("Welcome Padawan")
  sleep(3)
  clear_screen
end

def get_character_from_user

  our_star_wars_title("Choose, What?")
  user_input = hide_cursor_gets
  clear_screen
  character_or_film(user_input)
end

def character_or_film(user_input)
  if user_input.downcase == "character" || user_input.downcase == "c"
    our_star_wars_title("Character name?")
    character = hide_cursor_gets
    ready_for_main_theme
    show_character_movies(character)
  elsif user_input.downcase == "film" || user_input.downcase == "f"
    our_star_wars_title("Film name?")
    film = hide_cursor_gets
    ready_for_main_theme
    show_opening_crawl(film)
  end
end

def ready_for_main_theme
  clear_screen_quick
  volume_fade_quick
  `killall afplay`
  `osascript -e 'set volume output volume 50'`
end

def hide_cursor_gets
  STDIN.noecho(&:gets).chomp
end

def continue
  our_star_wars_title("shall we continue?")
  user_input = hide_cursor_gets
  continue_conditional(user_input)
end

def continue_conditional(user_input)
  if user_input == "yes"
    welcome
  elsif user_input == "no"
    return exit
  else
    complete_screen_clear
    incorrect_user_entry
    continue
  end
end

def incorrect_user_entry
  our_star_wars_title("yes or no")
  user_input = hide_cursor_gets
  continue_conditional(user_input)
end
