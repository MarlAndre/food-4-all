class Item < ApplicationRecord
  # geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  belongs_to :user
  has_and_belongs_to_many :allergens
  has_and_belongs_to_many :diets
  validates_presence_of :user_id, :description, :expiration_date, :item_type, :status, :name
  validates :description, length: { minimum: 5 }

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
end
