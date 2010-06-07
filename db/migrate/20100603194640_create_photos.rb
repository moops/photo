class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :gallery_id
      t.string :artist
      t.string :filename
      t.string :caption
      t.integer :sequence
      t.integer :views
      # attachment_fu fields
      t.string :source_file_name
      t.string :source_content_type
      t.integer :source_file_size
      t.datetime :source_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
