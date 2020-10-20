class CreateEvent < ActiveRecord::Migration[4.2]

    def change 
        create_table :events do |t|
            t.string :artist
            t.string :city
            t.string :venue
            t.datetime :date
        end
    end

end