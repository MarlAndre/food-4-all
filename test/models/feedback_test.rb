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
require "test_helper"

class FeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
