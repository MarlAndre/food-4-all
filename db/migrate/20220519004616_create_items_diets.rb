class CreateItemsDiets < ActiveRecord::Migration[6.1]
  def change
    create_table :items_diets do |t|
      t.references :item, null: false, foreign_key: true
      t.references :diet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
