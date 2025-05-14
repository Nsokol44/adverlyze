class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "email",
      "encrypted_password",
      "reset_password_token",
      "reset_password_sent_at",
      "remember_created_at",
      "created_at",
      "updated_at"
    ]
    end
end
