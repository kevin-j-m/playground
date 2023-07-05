class CreateSongArtist < ActiveRecord::Migration[7.0]
  def change
    create_table :song_artists do |t|
      t.references :song, foreign_key: true
      t.references :artist, foreign_key: true
      t.string :role
      t.timestamps
    end
  end
end
