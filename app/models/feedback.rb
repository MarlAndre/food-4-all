# == Schema Information
#
# Table name: feedbacks
#
#  id            :bigint           not null, primary key
#  communication :boolean          default(FALSE)
#  friendly      :boolean          default(FALSE)
#  punctual      :boolean          default(FALSE)
#  recommended   :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  request_id    :bigint
#  user_id       :bigint           not null
#
class Feedback < ApplicationRecord
  belongs_to :request
  validates_presence_of :request_id, :user_id
end
