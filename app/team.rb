class Team < ActiveRecord::Base

    has_many :games
    has_many :stadiums, through: :games

end