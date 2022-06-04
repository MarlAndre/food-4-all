class RemoveCoordinatesFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :latitude, :float
    remove_column :items, :longitude, :float
  end
end
