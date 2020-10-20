require 'rest-client'
require 'json'
require 'pry'

response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&locale=*')
response_hash = JSON.parse(response_string)


def gets_stadiums_by_city(city)

end

def gets_games_by_date(date)

end

def gets_schedule_by_team(team)

end

def gets_games_by_stadium(stadium)

end

# binding.pry