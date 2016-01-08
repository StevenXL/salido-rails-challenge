class CreateVineyards < ActiveRecord::Migration
  def change
    create_table :vineyards do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
