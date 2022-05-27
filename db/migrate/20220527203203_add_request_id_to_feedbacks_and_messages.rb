class AddRequestIdToFeedbacksAndMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :feedbacks, :request, foreign_key: true
    add_reference :messages, :request, foreign_key: true
  end
end
