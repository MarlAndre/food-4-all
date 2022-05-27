class AddStatusToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :status, :boolean, default: false
  end
end
