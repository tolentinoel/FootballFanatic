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

# <-----------------CLASS FUNCTIONS BELOW ------------------>

    def self.games_list
        response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&page=0&size=50&apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0')
        response_hash = JSON.parse(response_string)
        response_hash["_embedded"]["events"].each{|event| puts event["name"]+ " ==> ".colorize(:blue)+ event["dates"]["start"]["localDate"] +"\n".colorize(:orange) }
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

        if  games = Game.all.filter{|game| game.date === date}
            home_id = games.map{|ele| ele.home_team_id}
            away_id = games.map{|ele| ele.away_team_id}
            venue_id = games.map{|ele| ele.stadium_id}
            the_times = games.map{|ele| ele.time}
            the_dates = games.map{|ele| ele.date}

            i = 0
            while i < home_id.length || i < away_id.length do
                home_team = Team.all.filter{|team|
                    team.id === home_id[i]
                }.map{|e| e.name}

                away_team = Team.all.filter{|team|
                    team.id === away_id[i]
                }.map{|e| e.name}

                stadia = Stadia.all.filter{|v|
                    v.id === venue_id[i]
                }.map{|e| "#{e.name} (#{e.city})"}

                j = 0
                home_team.each{|name|
                    if away_team[j] != nil
                        puts "...................................................................".colorize(:red)
                        puts "   #{name} vs. #{away_team[j]}".colorize(:green) ++ " ==> #{the_dates[i]} @ #{the_times[i]}".colorize(:light_blue) + " ==> #{stadia[j]}".colorize(:red)
                    else
                        puts "..................................................................".colorize(:red)
                        puts "   #{name}".colorize(:green) + " ==> #{the_dates[i]} @ #{the_times[i]}".colorize(:light_blue) + " ==> #{stadia[j]}".colorize(:red)

                    end
                }
                j += 1
                i += 1
            end
        else
            puts "========================".colorize(:green)
            puts "No games found on this date.".colorize(:red)
        end
    end


    def self.gets_schedule_by_team(team)
        if result = Team.find_by(name: team)
            if result != nil
                games = Game.all.filter{|game| game.home_team_id === result.id}
                if !games.empty?
                    home_id = games.map{|ele| ele.home_team_id}
                    away_id = games.map{|ele| ele.away_team_id}
                    venue_id = games.map{|ele| ele.stadium_id}
                    the_times = games.map{|ele| ele.time}
                    the_dates = games.map{|ele| ele.date}
                else 
                    away_games = Game.all.filter{|game| game.away_team_id === result.id}
                    home_id = away_games.map{|ele| ele.home_team_id}
                    away_id = away_games.map{|ele| ele.away_team_id}
                    venue_id = away_games.map{|ele| ele.stadium_id}
                    the_times = away_games.map{|ele| ele.time}
                    the_dates = away_games.map{|ele| ele.date}
                end
                
                i = 0
                while i < home_id.length || i < away_id.length do
                    # FILTER TEAM DB BASED FROM ARRAY ELEMENTS
                    home_team = Team.all.filter{|team|
                        team.id === home_id[i]
                    }.map{|e| e.name}

                    away_team = Team.all.filter{|team|
                        team.id === away_id[i]
                    }.map{|e| e.name}

                    stadia = Stadia.all.filter{|v|
                        v.id === venue_id[i]
                    }.map{|e| "#{e.name} (#{e.city})"}

                    j = 0
                    home_team.each{|name|
                        # CHECK IF THERE'S AN AWAY TEAM ON FILTERED RESULTS (THIS IS MAKING ROOM FOR UPDATED DB THAT HAS AN AWAY TEAM-currently nil)
                        if away_team[j] != nil
                            puts "...................................................................".colorize(:red)
                            puts "   #{name} vs. #{away_team[j]}".colorize(:green) + " ==> #{the_dates[i]} @ #{the_times[i]}".colorize(:light_blue) + " ==> #{stadia[j]}".colorize(:red)
                        else
                        # MEANS IF DATA ONLY HAS A HOME TEAM(One performer events or games with a waiting list on opponent)
                            puts "..................................................................".colorize(:red)
                            puts "   #{name}".colorize(:green) + " ==> #{the_dates[i]} @ #{the_times[i]}".colorize(:light_blue) + " ==> #{stadia[j]}".colorize(:red)
                        end
                    }
                    j+= 1
                    i += 1
                end

        end
        else puts "++=============================================++".colorize(:red)
            puts "   No games found for this team on the database.".colorize(:red)
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

                j = 0
                home_team.each{|name|

                    if away_team[j] != nil
                        puts "...................................................................".colorize(:red)
                        puts "   #{name} vs. #{away_team[j]}".colorize(:green) + "==> #{the_dates[i]}".colorize(:red) + " @ #{the_times[i]}".colorize(:blue)
                    else
                        puts "..................................................................".colorize(:red)
                        puts "   #{name}".colorize(:green) + " ==> #{the_dates[i]}".colorize(:light_blue) + " @ #{the_times[i]}".colorize(:blue)
                    end
                }
                j += 1
                i += 1
            end

        else
            puts "================================".colorize(:red)
            puts "No games found at this stadium.".colorize(:red)
        end
    end



end
