class Impression < ApplicationRecord
  belongs_to :ad
  belongs_to :user

  after_create_commit { broadcast_append_to "ads" }
  # Optionally, for updates or deletes:
  after_update_commit { broadcast_replace_to "ads" }
  after_destroy_commit { broadcast_remove_to "ads" }

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      ad_id
      user_id
      latitude
      longitude
      created_at
      updated_at
    ]
  end
end
