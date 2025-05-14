class Review < ApplicationRecord
  belongs_to :ad
  belongs_to :user
  validates :rating, inclusion: { in: 1..5 }

  after_create_commit { broadcast_append_to "ads" }
  # Optionally, for updates or deletes:
  after_update_commit { broadcast_replace_to "ads" }
  after_destroy_commit { broadcast_remove_to "ads" }
  
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      user_id
      business_id
      rating
      comment
      created_at
      updated_at
    ]
  end
end

