class Song < ApplicationRecord
  self.strict_loading_by_default = true

  has_many :song_artists
  has_many :artists, through: :song_artists

  def artist_names
    artists.map(&:name).uniq
    # TODO: distinct in the DB?
  end

  def artist_involvement
    # TODO: better way?
    song_artists.each_with_object({}) do |song_artist, collection|
      if collection.key?(song_artist.artist_name)
        collection[song_artist.artist_name] << song_artist.role
      else
        collection[song_artist.artist_name] = [song_artist.role]
      end
    end
  end
end
