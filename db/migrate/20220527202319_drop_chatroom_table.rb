class DropChatroomTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :chatrooms do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
