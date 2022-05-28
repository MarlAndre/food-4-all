# == Schema Information
#
# Table name: requests
#
#  id          :bigint           not null, primary key
#  status      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  giver_id    :bigint           not null
#  item_id     :bigint           not null
#  receiver_id :bigint           not null
#
class Request < ApplicationRecord
  belongs_to :item
  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
  validates_presence_of :giver_id, :item_id, :receiver_id
  # one request can have two feedbacks (from receiver and giver)
  has_many :feedbacks
  # one chatroom represents one chatroom and has many messages
  has_many :messages
end
