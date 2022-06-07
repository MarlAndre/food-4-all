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
#  user_id       :bigint           not null
#
class Feedback < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id
end
