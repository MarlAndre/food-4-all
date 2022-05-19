class CreateDiets < ActiveRecord::Migration[6.1]
  def change
    create_table :diets do |t|
      t.string :name

      t.timestamps
    end
  end
end
