# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id               :bigint           not null, primary key
#  blocked          :boolean          default(FALSE), not null
#  favoritable_type :string           not null
#  favoritor_type   :string           not null
#  scope            :string           default("favorite"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  favoritable_id   :bigint           not null
#  favoritor_id     :bigint           not null
#
class Favorite < ApplicationRecord
  extend ActsAsFavoritor::FavoriteScopes

  belongs_to :favoritable, polymorphic: true
  belongs_to :favoritor, polymorphic: true

  def block!
    update!(blocked: true)
  end
end
