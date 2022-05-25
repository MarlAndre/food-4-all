# == Schema Information
#
# Table name: feedbacks
#
#  id                  :bigint           not null, primary key
#  communication       :boolean          default(FALSE)
#  friendly            :boolean          default(FALSE)
#  punctual            :boolean          default(FALSE)
#  recommended         :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  item_transaction_id :bigint           not null
#  user_id             :bigint           not null
#
class Feedback < ApplicationRecord
  belongs_to :item_transaction, class_name: "Transaction"
  validates_presence_of :item_transaction_id, :user_id
end
