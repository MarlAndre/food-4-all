# == Schema Information
#
# Table name: allergens
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Allergen < ApplicationRecord
  # Associations
  has_many :items_allergens
  has_many :items, through: :items_allergens

  # Validations
  validates :name, presence: true
end
