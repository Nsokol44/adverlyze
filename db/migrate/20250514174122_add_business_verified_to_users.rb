class AddBusinessVerifiedToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :business_verified, :boolean
  end
end
