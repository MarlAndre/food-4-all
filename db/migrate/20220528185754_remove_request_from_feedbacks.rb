class RemoveRequestFromFeedbacks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :feedbacks, :request_id, null: false, foreign_key: true
  end
end
