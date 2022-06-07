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
require "test_helper"

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
