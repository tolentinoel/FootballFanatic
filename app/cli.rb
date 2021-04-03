require_relative "../config/environment"
require "colorize"

class CLI

    def welcome
        puts
        puts
        fork{ exec 'afplay', "lib/William_Rosati_Floating_Also.mp3" }
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:green)
        puts "
    █▀▀ █▀█ █▀█ ▀█▀ █▄▄ ▄▀█ █░░ █░░ █▀▀ ▄▀█ █▄░█ ▄▀█ ▀█▀ █ █▀▀
    █▀░ █▄█ █▄█ ░█░ █▄█ █▀█ █▄▄ █▄▄ █▀░ █▀█ █░▀█ █▀█ ░█░ █ █▄▄".colorize(:yellow)
        puts
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:green)
        `say "Welcome to Football Fanatic!"`
    end

    def main_menu
        puts ""
        puts "   Please select an option.".colorize(:yellow)
        puts "+++==================================+++".colorize(:blue)
        puts "   A - List of Stadium".colorize(:yellow)
        puts "   0 - All games".colorize(:yellow)
        puts "   1 - Find stadium by city".colorize(:yellow)
        puts "   2 - Find all games on a given date".colorize(:yellow)
        puts "   3 - Find a game schedule for a given team".colorize(:yellow)
        puts "   4 - Find all games hosted by a given stadium".colorize(:yellow)
        puts "   5 - Exit".colorize(:yellow)
        puts
        input = get_user_input
        if input == "A"
            puts ""
            puts "   ALL THE STADIUM ON THE DATABASE BELOW:".colorize(:yellow)
            APICommunicator.stadia_list
        elsif input == "0"
            puts "ALL GAMES BELOW:".colorize(:yellow)
            APICommunicator.games_list
        elsif input == "1"
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
            puts ""
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:green)
            puts "            Thank you and see you again soon!".colorize(:red)
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:green)
            puts
            puts
            `say "Thank you and See you again soon!"`
            fork { exec 'killall', "afplay" }
            exit
        else
            puts "Invalid entry, please try again."
        end
        puts
        return self.main_menu
    end

    def get_user_input
        gets.chomp.strip
    end


end

