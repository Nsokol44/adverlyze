class Business < ApplicationRecord
  belongs_to :user
  has_many :ads, dependent: :destroy
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      name
      description
      images
      user_id
      created_at
      updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user] # or any other associations you want searchable
  end
  
end
