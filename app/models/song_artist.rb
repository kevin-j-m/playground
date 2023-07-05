class SongArtist < ApplicationRecord
  self.strict_loading_by_default = true

  belongs_to :song
  belongs_to :artist

  delegate :name, to: :artist, prefix: true
end
