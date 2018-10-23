require 'rest-client'
require 'json'
require 'pry'
require 'colorize'

def get_character_movies_from_api(character)
  response_string = RestClient.get("http://www.swapi.co/api/people/?search=#{character}")
  response_hash = JSON.parse(response_string)
  character = response_hash["results"]
  films_array = character.first["films"]
  pid = fork{ exec 'afplay', "imperial_march.mp3" }
  films_array.each do |url|
    get_film_info(url)
  end
  sleep(4)
  volume_fade
  `killall afplay`
  complete_screen_clear
end

def get_film_info(url)
  response_string = RestClient.get(url)
  film_hash = JSON.parse(response_string)
  print_movies(film_hash)
end

def print_movies(film_hash)
  title = film_hash["title"]
  release_date = film_hash["release_date"]
  director = film_hash["director"]
  puts ""
  print_value_with_label("TITLE:", title)
  sleep(1)
  print_value_with_label("DIRECTED BY:", director)
  sleep(1)
  print_value_with_label("RELEASE DATE:", release_date)
  sleep(1)
  puts "\n"
  delimiter
end

def print_value_with_label(label, value)
  puts white_space_offset(label) + label.colorize(:background => :red)
  puts white_space_offset(value) + value
end

def white_space_offset(line)
  white_space = ((`tput cols`.to_i) - line.length) / 2
  " " * white_space
end

def delimiter
  sleep(0.2)
  `tput cols`.to_i.times do
    print "* ".red
    sleep(0.005)
  end
  puts ""
  sleep(0.2)
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
end

def show_opening_crawl(title)
  response_string = RestClient.get("https://www.swapi.co/api/films/?search=#{title}")
  response_hash = JSON.parse(response_string)
  film = response_hash["results"].first
  film_title = film["title"]
  pid = fork{ exec 'afplay', "intro_music.mp3" }
  sleep(2)
  print_star_wars_logo(film_title)
   sleep(1)
  crawl(film["opening_crawl"])
  volume_fade
  `killall afplay`
end

def crawl(string)
  reposition_cursor(5)
  string.split("\r\n").each do |line|
    print white_space_offset(line)
    line.split("").each do |character|
      print character.light_yellow
      character_crawl(character)
    end
    puts ""
  end
  reposition_cursor(20)
end

def character_crawl(character)
  if character == "."
    sleep(1)
  elsif character == ","
    sleep(0.5)
  else
    sleep(0.05)
  end
end

def our_star_wars_title(string) #not called
  counter = 0
  title_array = string.split(" ")
  font = TTY::Font.new(:starwars)
  title_array.each do |word|
    starfont = font.write(word)
    starfont.split("\n").each do |line|
        counter += 1
        puts white_space_offset(line) + line
        sleep(0.1)
    end
    puts "\n"
  end
  return counter
end

# def volume_fade
#   set = `osascript -e 'output volume of (get volume settings)'`.to_i
#   volume = set
#   while true do
#     `osascript -e 'set volume output volume #{volume}'`
#     volume -= 2
#     sleep(0.01)
#     break if volume <= 0
#   end
#   sleep(0.5)
# end
#
# def volume_fade_quick
#    set = `osascript -e 'output volume of (get volume settings)'`.to_i
#    volume = set
#   while true do
#     `osascript -e 'set volume output volume #{volume}'`
#     volume -= 5
#     sleep(0.01)
#     break if volume <= 0
#   end
#   sleep(0.5)
# end
#
# def volume_fade_up
#   volume = 0
#   while true do
#     `osascript -e 'set volume output volume #{volume}'`
#     volume += 1
#     sleep(0.01)
#     break if volume == 50
#   end
# end
#
# def volume_fade_up_quick
#   volume = 0
#   while true do
#     `osascript -e 'set volume output volume #{volume}'`
#     volume += 5
#     sleep(0.01)
#     break if volume == 50
#   end
# end
