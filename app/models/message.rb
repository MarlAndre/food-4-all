# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  request_id :bigint
#  user_id    :bigint           not null
#
class Message < ApplicationRecord
  belongs_to :request
  belongs_to :user

  validates_presence_of :content, :request_id, :user_id

  def sender?(the_user)
    user.id == the_user.id
  end
end
