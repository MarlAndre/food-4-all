# == Schema Information
#
# Table name: items_diets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diet_id    :bigint           not null
#  item_id    :bigint           not null
#
require "test_helper"

class ItemsDietTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
