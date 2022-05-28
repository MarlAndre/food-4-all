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
  # Associations
  belongs_to :item
  belongs_to :allergen#, dependent: :destroy
end
