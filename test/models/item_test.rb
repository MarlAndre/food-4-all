# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  description     :text
#  expiration_date :date
#  status          :integer          default("available")
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
