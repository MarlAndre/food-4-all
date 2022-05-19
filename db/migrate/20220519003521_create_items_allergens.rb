class CreateItemsAllergens < ActiveRecord::Migration[6.1]
  def change
    create_table :items_allergens do |t|
      t.references :item, null: false, foreign_key: true
      t.references :allergen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
