
class CreateStadia < ActiveRecord::Migration[4.2]

    def change
        create_table :stadia do |t|
            t.string :name
            t.string :city
        end
    end

end