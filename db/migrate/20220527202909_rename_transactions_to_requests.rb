class RenameTransactionsToRequests < ActiveRecord::Migration[6.1]
  def change
    rename_table :transactions, :requests
  end
end
