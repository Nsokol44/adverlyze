class Ad < ApplicationRecord
  belongs_to :business
  has_many :impressions, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # Geolocation scope (PostGIS)
  scope :nearby, ->(lat, lng, radius = 5) {
    where(
      "ST_DWithin(ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)::geography, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?)",
      lng, lat, radius * 1000
    )
  }

  after_create_commit { broadcast_append_to "ads" }
  # Optionally, for updates or deletes:
  after_update_commit { broadcast_replace_to "ads" }
  after_destroy_commit { broadcast_remove_to "ads" }
end
