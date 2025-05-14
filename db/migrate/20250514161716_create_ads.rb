class CreateAds < ActiveRecord::Migration[8.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.references :business, null: false, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.integer :radius
      t.string :category
      t.string :images

      t.timestamps
    end
  end
end
