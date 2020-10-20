class CreateGame < ActiveRecord::Migration[4.2]

    def change 
        create_table :games do |t|
            t.string :teams
            t.string :city
            t.string :stadium
            t.datetime :date
        end
    end

end