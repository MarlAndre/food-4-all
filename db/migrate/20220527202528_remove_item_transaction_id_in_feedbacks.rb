class RemoveItemTransactionIdInFeedbacks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :feedbacks, :item_transaction, foreign_key: { to_table: :transactions }, null: false
  end
end
