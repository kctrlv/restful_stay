class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :password_digest
      t.string :phone_number
      t.string :description
      t.string :picture_url
      t.string :status

      t.timestamps null:false
    end
  end
end
