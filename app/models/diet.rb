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
  validates :name, presence: true
end
