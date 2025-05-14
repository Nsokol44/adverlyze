class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :description
      t.string :images
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
