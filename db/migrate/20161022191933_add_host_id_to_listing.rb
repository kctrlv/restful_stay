class AddHostIdToListing < ActiveRecord::Migration[5.0]
  def change
    remove_reference :listings, :user
    add_column :listings, :host_id, :integer
  end
end
