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
  # Associations
  acts_as_favoritable
  belongs_to :user
  has_many :items_diets, dependent: :destroy
  has_many :diets, through: :items_diets
  has_many :items_allergens, dependent: :destroy
  has_many :allergens, through: :items_allergens
  has_many :requests, dependent: :destroy
  has_many_attached :photos

  # Validations
  validates_presence_of :user_id, :photos, :description, :expiration_date, :item_type, :status, :name
  validates :description, length: { minimum: 7 }
  validates :name, length: { minimum: 3 }
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    errors.add(:expiration_date, "can't be in the past.") if expiration_date.present? && expiration_date < Date.today
  end

  TYPES = %w[meal ingredient]
  validates :item_type, inclusion: { in: TYPES }

  # Ex: READ instance using `item.reserved?`(boolean) and WRITE using `item.donated!`
  enum status: {
    available: 0,
    reserved: 1,
    donated: 2
  }

  # added "pg_search" gem to filter the index
  include PgSearch::Model
  multisearchable against: %i[name description item_type]

  # pg_search_scope :search_index,
  #   against: %i[name description item_type],
  #   associated_against: { user: :username },
  #   using: { tsearch: { prefix: true } }
end
