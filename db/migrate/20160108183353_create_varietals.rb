class CreateVarietals < ActiveRecord::Migration
  def change
    create_table :varietals do |t|
      t.string :name, null: false
      t.references :wine_type, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
