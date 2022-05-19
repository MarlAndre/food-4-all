class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0  # status type is enums (all statuses in item.rb)
      t.string :type
      t.text :description
      t.date :expiration_date

      t.timestamps
    end
  end
end
