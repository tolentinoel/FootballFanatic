
class CreateGame < ActiveRecord::Migration[4.2]

    def change
        create_table :games do |t|
            t.integer :home_team_id
            t.integer :away_team_id
            t.integer :stadium_id
            t.string :date
            t.string :time
        end
    end

end