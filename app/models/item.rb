# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  description     :text
#  expiration_date :date
#  item_type       :string
<<<<<<< HEAD
=======
#  name            :string
>>>>>>> master
#  status          :integer          default("available")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
class Item < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :allergens
  has_and_belongs_to_many :diets
<<<<<<< HEAD
  validates_presence_of :user_id, :description, :expiration_date, :item_type, :status
  validates :description, length: { minimum: 5 }

  TYPES = %w[meal ingredient]
  validates :item_type, inclusion: { in: TYPES }
  # in simple_form_for: f.select, collection: Item::TYPES
=======
  validates_presence_of :user_id, :description, :expiration_date, :item_type, :status, :name
  validates :description, length: { minimum: 5 }

  TYPES = %w[Meal Ingredient]
  validates :item_type, inclusion: { in: TYPES }
>>>>>>> master

  # has_many_attached :photos, :maximum => 5 # cloudinary to be installed

  # READ instance using `item.reserved?`(boolean) and WRITE using `item.donated!`
  enum status: {
    available: 0,
    reserved: 1,
    donated: 2
  }
end
