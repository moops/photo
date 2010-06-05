class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :gallery_id
      t.string :artist
      t.string :filename
      t.string :caption
      # attachment_fu fields
      t.string :src_file_name
      t.string :src_content_type
      t.integer :src_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
