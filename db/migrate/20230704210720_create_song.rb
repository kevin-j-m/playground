class CreateSong < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.timestamps
    end
  end
end
