# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  latitude               :float
#  longitude              :float
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  time_zone              :string           default("Eastern Time (US & Canada)")
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :items, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :requests_as_giver, class_name: "Request", foreign_key: :giver_id, dependent: :destroy
  has_many :requests_as_receiver, class_name: "Request", foreign_key: :receiver_id, dependent: :destroy
  # has_one_attached :photo # cloudinary to be installed

  # Validations
  # 'username' & 'address' fields are created on top of 'devise' gem
  validates_presence_of :email, :username, :password, :address
  validates_uniqueness_of :email, :username
end
