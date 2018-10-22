require 'rest-client'
require 'json'
require 'pry'

def get_people_from_api
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
    # response_string = RestClient.get('https://api.openaq.org/v1/countries')
  response_hash = JSON.parse(response_string)
  response_hash
end

def get_character_movies(character)
  films_hash = get_people_from_api['results'].find do |star_warrior|
    star_warrior['name'].downcase == character
  end
  films_hash
end

def print_movies(films_hash)
  films_array = []
  films_hash['films'].each do |film|
    response_film = RestClient.get(film)
    parsed_response = JSON.parse(response_film)['title']
    films_array << parsed_response
  end
  films_array.each do |title|
    puts title
  end
end

def show_character_movies(character)
  films_hash = get_character_movies(character)
  print_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?



# NOTE: in this demonstration we name many of the variables _hash or _array.
# This is done for educational purposes. This is not typically done in code.


# iterate over the response hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.
