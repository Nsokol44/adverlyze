class CreateImpressions < ActiveRecord::Migration[8.0]
  def change
    create_table :impressions do |t|
      t.references :ad, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
