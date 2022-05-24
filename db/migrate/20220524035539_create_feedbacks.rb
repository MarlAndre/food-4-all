class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      # Renamed the 'transaction_id' to 'item_transaction_id' after model testing.
      # ".transaction" will conflict with a method transaction already defined by Active Record.
      t.references :item_transaction, null: false, foreign_key: { to_table: :transactions }
      t.references :user, null: false, foreign_key: true
      t.boolean :punctual, default: false
      t.boolean :friendly, default: false
      t.boolean :communication, default: false
      t.boolean :recommended, default: false

      t.timestamps
    end
  end
end
