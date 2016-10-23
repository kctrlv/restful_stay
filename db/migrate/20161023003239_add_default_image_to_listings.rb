class AddDefaultImageToListings < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :image_url, :string, default: 'http://i.imgur.com/00aovFw.jpg'
  end
end
