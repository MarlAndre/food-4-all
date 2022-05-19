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
  has_and_belongs_to_many :items
end
