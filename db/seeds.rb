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
        stadia = Stadia.find_or_create_by(name: games["_embedded"]["venues"][0]["name"],
        city: games["_embedded"]["venues"][0]["city"]["name"])
        date = games["dates"]["start"]["localDate"]
        time = games["dates"]["start"]["localTime"]

        Game.find_or_create_by({home_team: home, away_team: away, stadium_id: stadia.id, date: date, time: time})
    end
end

get_obj_from_hash
