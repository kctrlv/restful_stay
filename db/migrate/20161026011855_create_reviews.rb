class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :trip, foreign_key: true
      t.string :subject
      t.string :body

      t.timestamps
    end
  end
end
