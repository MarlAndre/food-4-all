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
class ItemsAllergen < ApplicationRecord
  belongs_to :item
  belongs_to :allergen
end
