class FixType < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :type, :item_type
  end
end
