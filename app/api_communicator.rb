require 'rest-client'
require 'json'
require 'pry'
require_relative '../config/environment'
require "colorize"

class APICommunicator

    def get_main_hash
        response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&page=0&size=50&apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0')
        response_hash = JSON.parse(response_string)
    end

    def all_games
        get_main_hash["_embedded"]["events"]
    end

    def self.games_list
        response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&page=0&size=50&apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0')
        response_hash = JSON.parse(response_string)
        response_hash["_embedded"]["events"].each{|event| puts event["name"]+ " ==> " + event["dates"]["start"]["localDate"] +"\n" }
    end

    def self.stadia_list

        puts "__________________________________________".colorize(:green)
        puts ""
        Stadia.all.each{|s|
            puts "......................................................................".colorize(:red)
            puts "  #{s.name} ~~ #{s.city}" + "\n"
        }
    end

    def self.gets_stadiums_by_city(city)
        if  stadium = Stadia.find_by(city: city)
            city == stadium["city"]
            puts "========================".colorize(:green)
            puts stadium["name"].colorize(:green)
        else
            puts "========================".colorize(:green)
            puts "No stadiums found in this city.".colorize(:red)
        end
    end


    def self.gets_games_by_date(date)

        if  games = Game.find_by(date: date)
            date == games["date"].to_s.delete_suffix(' 00:00:00 UTC')
            var = Game.find_by(date: date)
            home_team_id = Game.find_by(date: date)["home_team_id"]
            home_team_name = Team.find_by(id: home_team_id)["name"]
            away_team_id = Game.find_by(date: date)["away_team_id"]
            away_team_name = Team.find_by(id: away_team_id)["name"]
            puts "========================".colorize(:green)

            if away_team_name != nil
                puts "#{home_team_name} vs. #{away_team_name}".colorize(:green)
            else
                puts "#{home_team_name}".colorize(:blue)
            end
        else
            puts "========================".colorize(:green)
            puts "No games found on this date.".colorize(:red)
        end
    end

    def self.gets_schedule_by_team(team)
        if result = Team.find_by(name: team)
            if result.id.even? == true
                #Is the given team the away team? If not, sends to else statement
                
                away_games_obj = Game.find_by(away_team_id: result.id)
                home_team_id = away_games_obj["home_team_id"]
                home_team_name = Team.find_by(id: home_team_id)["name"]
                #If I'm searching for away team results, I need to decrement the result.id by 1 so that home_game_obj != nil
                #Code written to accomodate how the database is set up

                home_games_obj = Game.find_by(home_team_id: result.id-1)
                away_team_id = home_games_obj["away_team_id"]
                away_team_name = Team.find_by(id: away_team_id)["name"]
                date = home_games_obj.date.to_s.delete_suffix(' 00:00:00 UTC')

                    if home_team_name != nil
                        puts ""
                        puts "       EVENT SCHEDULE".colorize(:green)
                        puts "+++===========================+++".colorize(:green)
                        puts "         #{date}".colorize(:green)
                        puts "  #{result.name} vs. #{home_team_name}".colorize(:green)

                    else
                        puts ""
                        puts "         EVENT SCHEDULE".colorize(:blue)
                        puts "+++===========================+++".colorize(:green)
                        puts "      #{date}".colorize(:green)
                        puts "        #{result.name}".colorize(:light_blue)

                    end

                else
                    home_games_obj = Game.find_by(home_team_id: result.id)
                    away_team_id = home_games_obj["away_team_id"]
                    away_team_name = Team.find_by(id: away_team_id)["name"]
                    #If I'm searching for away team results, I need to increment the result.id by 1
                    away_games_obj = Game.find_by(away_team_id: result.id+1)
                    home_team_id = away_games_obj["home_team_id"]
                    home_team_name = Team.find_by(id: home_team_id)["name"]
                    date = home_games_obj.date.to_s.delete_suffix(' 00:00:00 UTC')

                    if away_team_name != nil
                        puts ""
                        puts "        EVENT SCHEDULE".colorize(:green)
                        puts "+++===========================+++".colorize(:green)
                        puts "           #{date}".colorize(:green)
                        puts "  #{result.name} vs. #{home_team_name}".colorize(:green)

                    else
                        puts ""
                        puts "         EVENT SCHEDULE".colorize(:blue)
                        puts "+++===========================+++".colorize(:green)
                        puts "  #{date}".colorize(:green)
                        puts "  #{result.name}".colorize(:light_blue)

                    end

            end
        else puts "============================================".colorize(:red)
            puts "No games found for this team on the database.".colorize(:red)
        end
    end


    def self.gets_games_by_stadium(stadium)

        if stadium_obj = Stadia.find_by(name: stadium)
         
            stadium_games = Game.all.filter{|game| game.stadium_id === stadium_obj.id}
            home_id = stadium_games.map{|ele| ele.home_team_id}
            away_id = stadium_games.map{|ele| ele.away_team_id}
            the_times = stadium_games.map{|ele| ele.time}
            the_dates = stadium_games.map{|ele| ele.date}


                i = 0
                while i < home_id.length || i < away_id.length do
                    home_team = Team.all.filter{|team|
                        team.id === home_id[i]
                    }.map{|e| e.name}

                    away_team = Team.all.filter{|team|
                        team.id === away_id[i]
                    }.map{|e| e.name}


                    home_team.each{|name|
                       
                        if away_team[i] != nil
                            puts "...................................................................".colorize(:red)
                            puts "   #{name} vs. AWAY".colorize(:green) + "==> #{the_dates[i]}".colorize(:red) + " @ #{the_times[i]}".colorize(:blue)
                        else
                            puts "..................................................................".colorize(:red)
                            puts "   #{name}".colorize(:green) + " ==> #{the_dates[i]}".colorize(:light_blue) + " @ #{the_times[i]}".colorize(:blue)
                        end
                    }
                    i += 1
                end

        else
            puts "================================".colorize(:red)
            puts "No games found at this stadium.".colorize(:red)
        end
    end



end