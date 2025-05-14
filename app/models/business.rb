class Business < ApplicationRecord
  belongs_to :user
  has_many :ads, dependent: :destroy
  validates :name, presence: true
end
