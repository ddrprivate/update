class CreateAlbum < ActiveRecord::Migration[5.2]
  def change
	create_table :album do |t|
		t.text :name
		t.integer :words
	end
  end
end
