class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :city
      t.string :city_s
      t.string :state
      t.string :state_s
      t.string :road
      t.string :road_s
      t.string :office

      t.timestamps null: false
    end
  end
end
