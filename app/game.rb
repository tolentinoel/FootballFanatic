class Game < ActiveRecord::Base

    belongs_to :teams
    belongs_to :stadium

end