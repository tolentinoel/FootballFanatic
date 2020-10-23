class Team < ActiveRecord::Base

    has_many :games, :foreign_key => "home_team_id"
    has_many :games, :foreign_key => "away_team_id"
    has_many :stadia, through: :games

end