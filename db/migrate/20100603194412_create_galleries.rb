class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.string :name
      t.string :code
      t.string :private_key
      t.date :gallery_on
      t.string :default_photo

      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
