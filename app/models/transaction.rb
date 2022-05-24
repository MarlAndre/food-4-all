# == Schema Information
#
# Table name: transactions
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  giver_id    :bigint           not null
#  item_id     :bigint           not null
#  receiver_id :bigint           not null
#
class Transaction < ApplicationRecord
  belongs_to :item
  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
  validates_presence_of :giver_id, :item_id, :receiver_id
  has_one :feedback_as_item_transaction, class_name: "Transaction", foreign_key: :item_transaction_id
end
