require 'rest-client'
require 'json'
require 'pry'

def get_main_hash
    response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&locale=*')
    response_hash = JSON.parse(response_string)
end 

def all_games
    get_main_hash["_embedded"]["events"]
end

def gets_stadiums_by_city(city)
    all_venues = []
    all_games.each do |games|
        games["_embedded"]["venues"].each do |vi|
            city_name = vi["city"]["name"] 
            # puts vi["city"]
            if city == city_name
                all_venues << vi["name"]
            end 
        end 
    end 
    puts all_venues.uniq
end
gets_stadiums_by_city("Tampa")

 

def gets_games_by_date(date)

end

def gets_schedule_by_team(team)

end

def gets_games_by_stadium(stadium)

end

# binding.pry