class Artist < ActiveRecord::Base

    has_many :concerts
    has_many :venues, through: :concerts

end