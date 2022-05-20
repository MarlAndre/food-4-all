# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  description     :text
#  expiration_date :date
#  status          :integer          default("available")
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
class Item < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :allergens
  has_and_belongs_to_many :diets
  validates_presence_of :user_id, :description, :expiration_date, :type, :status
  validates :description, length: { minimum: 5 }

  TYPES = %w[Meal Ingredient]
  validates :type, inclusion: { in: TYPES }
  # in simple_form_for: f.select, collection: Item::TYPES

  # has_many_attached :photos, :maximum => 5 # cloudinary to be installed

  enum status: {
    available: 0,
    reserved: 1,
    donated: 2
  }
end
