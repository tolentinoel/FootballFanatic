class CreateConcert < ActiveRecord::Migration[4.2]

    def change 
        create_table :concerts do |t|
            t.string :artist_name
            t.string :city
            t.string :venue
            t.datetime :date
        end
    end

end