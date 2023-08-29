class CreateComments < ActiveRecord::Migration[7.0]
  def change
    # with only primary_key option set as a symbol:
    # ArgumentError: you can't redefine the primary key column 'identifier'. To define a custom primary key, pass { id: false } to create_table
    create_table :comments, primary_key: "identifier" do |t|
      # t.integer :identifier, null: false
      t.timestamps
    end
  end
end
