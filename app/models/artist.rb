class Artist < ApplicationRecord
  self.strict_loading_by_default = true

  has_many :song_artists
  has_many :songs, through: :song_artists
end
