class CreateAppellations < ActiveRecord::Migration
  def change
    create_table :appellations do |t|
      t.references :region, index: true, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
