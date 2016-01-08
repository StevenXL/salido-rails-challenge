class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name, null: false
      t.decimal :price_min, null: false
      t.decimal :price_max, null: false
      t.decimal :price_retail, null: false
      t.string :year

      t.references :appellation, index: true, foreign_key: true
      t.references :varietal, index: true, foreign_key: true
      t.references :vineyard, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
