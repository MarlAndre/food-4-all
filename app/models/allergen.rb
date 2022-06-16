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
  NAMES = ['milk', 'eggs', 'fish', 'shellfish', 'tree nuts', 'peanuts', 'wheat', 'soybeans']
  validates :name, presence: true, inclusion: { in: NAMES }

  # added "pg_search" gem to filter the index
  include PgSearch::Model
  multisearchable against: [:name]
end
