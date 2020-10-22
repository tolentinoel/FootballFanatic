require_relative '../app/api_communicator.rb'
require_relative '../config/environment'

#iterate through api to get all_teams array
#iterate through all_teams array to Team.create and seed our database

def get_all_teams
    all_teams = []
    all_games.each do |games|
        games["_embedded"]["attractions"].each do |ti|
            all_teams << ti["name"]
        end
    end
    all_teams.delete("Eagles")
    return all_teams.uniq
end

def create_new_teams_in_db
    get_all_teams.each do |team|
    Team.create(name: team)
    end
end

def get_all_stadiums
    all_stadiums = []
    all_stadium_cities = []
    all_games.each do |games|
        games["_embedded"]["venues"].each do |vi|
            all_stadiums << vi["name"]
        end
    end
    all_games.each do |games|  
        games["_embedded"]["venues"].each do |vi|
            all_stadium_cities << vi["city"]["name"]
        end
    end 
    return Hash[all_stadium_cities.zip(all_stadiums)]
end

def create_new_stadiums_in_db
    get_all_stadiums.each do |c, s|
    Stadium.create(name: s, city: c)
    end
end


def get_all_games
    all_games_info = []
    all_games.each do |games|
        this_name = games["name"]
        games["_embedded"]["venues"].each do |vi| 
            this_city = vi["city"]["name"]
            games["_embedded"]["venues"].each do |vi| 
                this_stadium = vi["name"]
                this_date = games["dates"]["start"]["localDate"]
                all_games_info << {name: this_name, city: this_city, stadium: this_stadium, date: this_date}
            end
        end
    end
    all_games_info.reject!{|h| h[:name]=="Eagles"} 
end 

def create_new_games_in_db
    array = get_all_games
    array.each do |h|
        Game.create(name: h[:name], city: h[:city], stadium: h[:stadium], date: h[:date])
    end 
end
create_new_games_in_db

