# == Schema Information
#
# Table name: diets
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Diet < ApplicationRecord
  # Associations
  has_many :items_diets
  has_many :items, through: :items_diets

  # Validations
  NAMES = ['vegan', 'vegetarian', 'pescatarian', 'lactose free', 'gluten free']
  validates :name, presence: true, inclusion: { in: NAMES }

  # added "pg_search" gem to filter the index
  include PgSearch::Model
  multisearchable against: [:name]
end
