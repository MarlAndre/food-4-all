class AddRequestIdToFeedbacksAndMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :feedbacks, :request, foreign_key: true, null: false
    add_reference :messages, :request, foreign_key: true, null: false
  end
end
