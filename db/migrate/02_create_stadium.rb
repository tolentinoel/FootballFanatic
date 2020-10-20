class CreateStadium < ActiveRecord::Migration[4.2]

    def change
        create_table :stadiums do |t|
            t.string :name
            t.string :city
        end
    end

end