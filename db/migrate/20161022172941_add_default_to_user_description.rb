class AddDefaultToUserDescription < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :description, :string, default: "No Description"
  end
end
