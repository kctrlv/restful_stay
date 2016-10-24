class CreateListingDays < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_days do |t|
      t.references :listing, foreign_key: true
      t.references :day, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
