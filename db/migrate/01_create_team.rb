class CreateTeam < ActiveRecord::Migration[4.2]

    def change
        create_table :teams do |t|
            t.string :name
            t.string :city
        end
    end

end