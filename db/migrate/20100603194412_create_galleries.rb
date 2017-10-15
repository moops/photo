class CreateGalleries < ActiveRecord::Migration[5.1]
  def self.up
    create_table :galleries do |t|
      t.string :name
      t.string :code
      t.string :private_key
      t.references :user
      t.date :gallery_on
      t.integer :default_photo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
