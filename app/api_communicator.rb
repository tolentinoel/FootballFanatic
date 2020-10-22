require 'rest-client'
require 'json'
require 'pry'
# require '../app/team.rb'

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
    puts
    puts all_venues.uniq
end

def gets_games_by_date(date)
    all_games_on_this_day = []
    all_games.each do |games|
        game_date = games["dates"]["start"]["localDate"]
        if date == game_date
            all_games_on_this_day << games["name"]
        end
    end
    puts
    puts all_games_on_this_day
end


def gets_schedule_by_team(team)
    team_schedule = []
    all_games.each do |games|
        game_teams = games["name"].split(" vs. ")
        if game_teams.include?(team)
            team_schedule << games["dates"]["start"]["localDate"]
            team_schedule << games["name"]  
        end
    end
    puts
    puts team_schedule
end
# gets_schedule_by_team("Philadelphia Eagles")

def gets_games_by_stadium(stadium)
    all_games_at_stadium = []
    all_games.each do |games|
        games["_embedded"]["venues"].each do |vi|
            stadium_name = vi["name"]
            if stadium == stadium_name
                all_games_at_stadium << games["dates"]["start"]["localDate"]
                all_games_at_stadium << games["name"]
            end
        end
    end
    puts
    puts all_games_at_stadium
end
# gets_games_by_stadium("Raymond James Stadium")




