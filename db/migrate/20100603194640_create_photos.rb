class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.references :gallery
      t.string :artist
      t.string :caption
      t.integer :sequence
      t.integer :views
      t.string :img
      #exif details
      t.datetime :photo_at
      t.string :shutter_speed
      t.string :aperture
      t.string :focal_length
      t.string :iso
      t.string :exposure_mode
      t.string :flash
      t.string :exposure_compensation
      t.string :camera_model

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
