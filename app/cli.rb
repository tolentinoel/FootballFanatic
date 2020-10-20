class CLI

    def welcome
        puts "Welcome to Ticketmaster"
    end

    def main_menu
        puts "Please select an option."
        puts "========================"
        puts "1. Find stadium by city"
        puts "2. Find all games on a given date"
        puts "3. Find a game schedule for a given team"
        puts "4. Find all games hosted by a given stadium"
        puts "5. Exit"
        puts 
        input = get_user_input
        if input == "1"
            puts "Which city?"
        city = get_user_input
        gets_stadiums_by_city(city)
        elsif input == "2"
            puts "What date?"
        date = get_user_input
        gets_games_by_date(date)
        elsif input == "3"
            puts "Which team?"
        team = get_user_input
        gets_schedule_by_team(team)
        elsif input == "4"
            puts "Which stadium?"
        stadium = get_user_input
        gets_games_by_stadium(stadium)
        elsif input == "5"
            exit
        else 
            puts "Invalid entry, please try again."
        end
        return self.main_menu
    end 



    def get_user_input
        gets.chomp
    end


end