class AddDefaultStatusToListingDays < ActiveRecord::Migration[5.0]
  def change
    change_column :listing_days, :status, :string, default: "available"
  end
end
