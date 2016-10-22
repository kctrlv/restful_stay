class AddImageUrlToCity < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :image_url, :string, default: 'https://i.ytimg.com/vi/TDXXQz8amFU/maxresdefault.jpg'
  end
end
