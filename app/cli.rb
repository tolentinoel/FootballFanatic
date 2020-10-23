require_relative "../config/environment"
require "colorize"

class CLI

    def welcome
        puts ""
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:green)
        puts "Welcome to the FootballFanatic app!".colorize(:yellow)
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:green)
    end

    def main_menu
        puts ""
        puts "Please select an option.".colorize(:yellow)
        puts "========================".colorize(:green)
        puts "1. Find stadium by city".colorize(:yellow)
        puts "2. Find all games on a given date".colorize(:yellow)
        puts "3. Find a game schedule for a given team".colorize(:yellow)
        puts "4. Find all games hosted by a given stadium".colorize(:yellow)
        puts "5. Exit".colorize(:yellow)
        puts
        input = get_user_input
        if input == "1"
            puts "Which city?".colorize(:yellow)
        city = get_user_input
        APICommunicator.gets_stadiums_by_city(city)
        elsif input == "2"
            puts "What date? Please use YYYY-MM-DD format.".colorize(:yellow)
        date = get_user_input
        APICommunicator.gets_games_by_date(date)
        elsif input == "3"
            puts "Which team?".colorize(:yellow)
        team = get_user_input
        APICommunicator.gets_schedule_by_team(team)
        elsif input == "4"
            puts "Which stadium?".colorize(:yellow)
        stadium = get_user_input
        APICommunicator.gets_games_by_stadium(stadium)
        elsif input == "5"
            exit
        else
            puts "Invalid entry, please try again."
        end
        puts
        return self.main_menu
    end

    def get_user_input
        gets.chomp
    end


end