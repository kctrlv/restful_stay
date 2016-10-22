class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.decimal :price_per_night
      t.references :city, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
