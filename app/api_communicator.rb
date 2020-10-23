require 'rest-client'
require 'json'
require 'pry'
require_relative '../config/environment'

# class APICommunicator


    def get_main_hash
        response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&locale=*')
        response_hash = JSON.parse(response_string)
    end

    def all_games
        get_main_hash["_embedded"]["events"]
    end

    def gets_stadiums_by_city(city)
        stadium = Stadia.find_by(city: city)
        if city == stadium["city"]
            puts stadium["name"]
        end
    end

    def gets_games_by_date(date)
        games = Game.find_by(date: date)
        # binding.pry
        if date == games["date"].to_s.delete_suffix(' 00:00:00 UTC')
            var = Game.find_by(date: date)
            home_team_id = Game.find_by(date: date)["home_team_id"]
            home_team_name = Team.find_by(id: home_team_id)["name"]
            away_team_id = Game.find_by(date: date)["away_team_id"]
            away_team_name = Team.find_by(id: away_team_id)["name"]
            puts "#{home_team_name} vs. #{away_team_name}"
        end
        # game = Game.find_by(date: date)
        # # binding.pry
        # if date == game["date"]
        # puts game["home_team_id"]
        # end
    end

    def gets_schedule_by_team(team)
        game = Game.find_by(team)
        if team == game["team"]
            puts game["date"]
        end
    end

    def gets_games_by_stadium(stadium)
        stadium_obj = Stadia.find_by(name: stadium)
        if stadium == stadium_obj["name"] 
            var = Game.find_by(stadium_id: stadium_obj.id)["away_team_id"]
            away_team = Team.find_by(id: var)["name"]
            var2 = Game.find_by(stadium_id: stadium_obj.id)["home_team_id"]
            home_team = Team.find_by(id: var2)["name"]
            the_date = Game.find_by(stadium_id: stadium_obj.id)["date"]
            puts "#{home_team} vs. #{away_team}"
            puts "#{the_date}"
        end 
    end


    # def gets_stadiums_by_city(city)
    #     all_venues = []
    #     all_games.each do |games|
    #         games["_embedded"]["venues"].each do |vi|
    #             city_name = vi["city"]["name"]
    #             if city == city_name
    #                 all_venues << vi["name"]
    #             end
    #         end
    #     end
    #     puts
    #     puts all_venues.uniq
    #     # puts "No stadiums found in this city."
    # end

    # def gets_stadiums_by_city(city)
    #     Stadium.find_by city: city
    #     # binding.pry
    # end 
    # gets_stadiums_by_city("Houston")

    # def gets_games_by_date(date)
    #     all_games_on_this_day = []
    #     all_games.each do |games|
    #         game_date = games["dates"]["start"]["localDate"]
    #         if date == game_date
    #             all_games_on_this_day << games["name"]
    #         end
    #     end
    #     puts
    #     puts all_games_on_this_day
    # end


    # def gets_schedule_by_team(team)
    #     team_schedule = []
    #     all_games.each do |games|
    #         game_teams = games["name"].split(" vs. ")
    #         if game_teams.include?(team)
    #             team_schedule << games["dates"]["start"]["localDate"]
    #             team_schedule << games["name"]  
    #         end
    #     end
    #     puts
    #     puts team_schedule
    # end
    # gets_schedule_by_team("Philadelphia Eagles")

    # def gets_games_by_stadium(stadium)
    #     all_games_at_stadium = []
    #     all_games.each do |games|
    #         games["_embedded"]["venues"].each do |vi|
    #             stadium_name = vi["name"]
    #             if stadium == stadium_name
    #                 all_games_at_stadium << games["dates"]["start"]["localDate"]
    #                 all_games_at_stadium << games["name"]
    #             end
    #         end
    #     end
    #     puts
    #     puts all_games_at_stadium
    # end
    # gets_games_by_stadium("Raymond James Stadium")

# end 