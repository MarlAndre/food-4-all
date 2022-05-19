# == Schema Information
#
# Table name: items_allergens
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  allergen_id :bigint           not null
#  item_id     :bigint           not null
#
require "test_helper"

class ItemsAllergenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
