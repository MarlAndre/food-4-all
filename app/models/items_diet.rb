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
class ItemsDiet < ApplicationRecord
  belongs_to :item
  belongs_to :diet
end
