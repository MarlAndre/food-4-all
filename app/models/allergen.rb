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
  has_and_belongs_to_many :items
  validates :name, presence: true, uniqueness: true

  # examples of major food allergens:
  # milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, and soybeans.
  # reference: https://www.fda.gov/food/food-labeling-nutrition/food-allergies#:~:text=Food%20allergies%20occur%20when%20the,fatal%20respiratory%20problems%20and%20shock
end
