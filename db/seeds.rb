require_relative '../config/environment'
require 'pry'
Team.destroy_all
Stadia.destroy_all
Game.destroy_all

$comm = APICommunicator.new

def get_obj_from_hash
    $comm.all_games.each do |games|
        home = Team.create(name: games["name"].split(" vs. ")[0])
        away = Team.create(name: games["name"].split(" vs. ")[1])
        stadia = Stadia.create(name: games["_embedded"]["venues"][0]["name"],
        city: games["_embedded"]["venues"][0]["city"]["name"])
        # binding.pry
        date = games["dates"]["start"]["localDate"].to_str
        Game.create({home_team: home, away_team: away, stadium_id: stadia.id, date: date})
    end
end

get_obj_from_hash

# def get_all_teams
#     all_teams = []
#     # binding.pry
#     $comm.all_games.each do |games|
#         games["_embedded"]["attractions"].each do |ti|
#             all_teams << ti["name"]
#         end
#     end
#     all_teams.delete("Eagles")
#     return all_teams.uniq
# end
# # get_all_teams
# # binding.pry

# def create_new_teams_in_db
#     get_all_teams.each do |team|
#     Team.create(name: team)
#     end
# end
# # create_new_teams_in_db

# def get_all_stadiums
#     all_stadiums = []
#     all_stadium_cities = []
#     $comm.all_games.each do |games|
#         games["_embedded"]["venues"].each do |vi|
#             all_stadiums << vi["name"]
#         end
#     end
#     $comm.all_games.each do |games|  
#         games["_embedded"]["venues"].each do |vi|
#             all_stadium_cities << vi["city"]["name"]
#         end
#     end 
#     return Hash[all_stadium_cities.zip(all_stadiums)]
# end
# # get_all_stadiums
# # binding.pry


# def create_new_stadiums_in_db
#     get_all_stadiums.each do |c, s|
#         Stadia.create(name: s, city: c)
#         # binding.pry
#     end
# end
# # create_new_stadiums_in_db


# def get_all_games
#     all_games_info = []
#     $comm.all_games.each do |games|

#         away_team = games["name"].split(" vs. ")[1]
#         games["_embedded"]["venues"].each do |vi| 
#             this_city = vi["city"]["name"]
#             games["_embedded"]["venues"].each do |vi| 
#                 this_stadium = vi["name"]
#                 this_date = games["dates"]["start"]["localDate"]
#                 all_games_info << {away_team: away_team, city: this_city, stadium: this_stadium, date: this_date}
#             end
#         end
#     end
#     all_games_info
#     # binding.pry 
#     # .reject!{|h| h[:away_team]=="Eagles"} 
# end 

# # puts get_all_games
# def create_new_games_in_db
#     get_all_games.each do |h|
#         Game.create(away_team: h[:away_team], city: h[:city], stadia: h[:stadia], date: h[:date])
#     end 
# end
# # create_new_games_in_db

