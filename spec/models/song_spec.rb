require "rails_helper"

RSpec.describe Song do
  context "strict loading" do
    it "artist_names requires the artist be strict loaded" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.all

      expect { songs.map(&:artist_names) }.to raise_error ActiveRecord::StrictLoadingViolationError
    end

    it "artist_names is happy with the artist included" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.all.includes(:artists)

      expect(songs.map(&:artist_names)).to match_array [["A"]]
    end

    it "artist_involvement requires the song_artist to be strict loaded" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.all

      expect { songs.map(&:artist_involvement) }.to raise_error ActiveRecord::StrictLoadingViolationError
    end

    it "artist_involvement is happy with the song_artist and artist included" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.all.includes(song_artists: :artist)

      expect(songs.map(&:artist_involvement)).to match_array [{"A"=>["guitar", "vocals"]}]
    end

    it "is happy with the same includes with strict loading on the association" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.strict_loading.all.includes(song_artists: :artist)

      expect(songs.map(&:artist_involvement)).to match_array [{"A"=>["guitar", "vocals"]}]
    end

    it "wants artists included explicitly when using both associations" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.all.includes(song_artists: :artist)

      songs.map(&:artist_involvement)
      expect { songs.map(&:artist_names) }.to raise_error ActiveRecord::StrictLoadingViolationError
    end

    it "wants song_artists and artists included explicitly when using both associations" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.all.includes(:artists)

      songs.map(&:artist_names)
      songs.map(&:artist_involvement)
      # expect { songs.map(&:artist_involvement) }.to raise_error ActiveRecord::StrictLoadingViolationError
    end

    it "is happy with both the artist included and the song artists, even if they're all through the same associations" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.all.includes(:artists)

      songs.map(&:artist_involvement)
      songs.map(&:artist_names)
      # D, [2023-07-04T20:06:15.867288 #56324] DEBUG -- :   Song Load (0.3ms)  SELECT "songs".* FROM "songs"
      # D, [2023-07-04T20:06:15.899794 #56324] DEBUG -- :   SongArtist Load (0.3ms)  SELECT "song_artists".* FROM "song_artists" WHERE "song_artists"."song_id" = $1  [["song_id", 58]]
      #     D, [2023-07-04T20:06:15.903058 #56324] DEBUG -- :   Artist Load (0.2ms)  SELECT "artists".* FROM "artists" WHERE "artists"."id" = $1  [["id", 58]]
    end

    it "loads song artists and artists again when strict loading the association and wants song artists explicitly loaded" do
      a = Artist.create(name: "A")
      song = Song.create(title: "Foo")
      song.song_artists.create!(artist: a, role: "guitar")
      song.song_artists.create!(artist: a, role: "vocals")

      songs = Song.strict_loading.all.includes(:artists, song_artists: :artist)

      songs.map(&:artist_involvement)
      songs.map(&:artist_names)
      # D, [2023-07-04T20:07:04.905419 #56553] DEBUG -- :   Song Load (0.2ms)  SELECT "songs".* FROM "songs"
# D, [2023-07-04T20:07:04.941642 #56553] DEBUG -- :   SongArtist Load (0.5ms)  SELECT "song_artists".* FROM "song_artists" WHERE "song_artists"."song_id" = $1  [["song_id", 59]]
# D, [2023-07-04T20:07:04.943890 #56553] DEBUG -- :   Artist Load (0.3ms)  SELECT "artists".* FROM "artists" WHERE "artists"."id" = $1  [["id", 59]]
# D, [2023-07-04T20:07:04.945526 #56553] DEBUG -- :   SongArtist Load (0.4ms)  SELECT "song_artists".* FROM "song_artists" WHERE "song_artists"."song_id" = $1  [["song_id", 59]]
# D, [2023-07-04T20:07:04.946843 #56553] DEBUG -- :   Artist Load (0.2ms)  SELECT "artists".* FROM "artists" WHERE "artists"."id" = $1  [["id", 59]]
    end
  end
end
