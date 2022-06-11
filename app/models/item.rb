# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  description     :text
#  expiration_date :date
#  item_type       :string
#  name            :string
#  status          :integer          default("available")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
class Item < ApplicationRecord
  acts_as_favoritable
  belongs_to :user
  has_many :items_diets, dependent: :destroy
  has_many :diets, through: :items_diets
  has_many :items_allergens, dependent: :destroy
  has_many :allergens, through: :items_allergens
  has_many :requests, dependent: :destroy
  has_many_attached :photos

  # Validations
  validates_presence_of :user_id, :description, :expiration_date, :item_type, :status, :name
  validates :description, length: { minimum: 10 }

  TYPES = %w[meal ingredient]
  validates :item_type, inclusion: { in: TYPES }

  # has_many_attached :photos, :maximum => 5 # cloudinary to be installed

  # Ex: READ instance using `item.reserved?`(boolean) and WRITE using `item.donated!`
  enum status: {
    available: 0,
    reserved: 1,
    donated: 2
  }

  # added "pg_search" gem to filter the index by name/description
  include PgSearch::Model
  pg_search_scope :search_index,
    against: %i[name description],
    associated_against: { user: :username },
    using: { tsearch: { prefix: true } }

  # This calculates the distance from the item's owner to the user who is using the website and entered their postal code.
  def distance_from(current_location)
    owner_coordinates = Geocoder.coordinates(user.address)
    Geocoder::Calculations.distance_between(owner_coordinates, current_location)
  end
end
