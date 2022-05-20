class UpdateItemsTable < ActiveRecord::Migration[6.1]
  def change
    change_table :items do |t|
      t.rename :type, :item_type
    end
  end
end
