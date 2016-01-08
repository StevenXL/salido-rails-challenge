class CreateWineTraits < ActiveRecord::Migration
  def change
    create_table :wine_traits do |t|
      t.references :wine, foreign_key: true, index: true, null: false
      t.references :trait, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
