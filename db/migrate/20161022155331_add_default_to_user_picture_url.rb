class AddDefaultToUserPictureUrl < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :picture_url, :string, default: "https://www.mautic.org/media/images/default_avatar.png"
  end
end
