class CreateComments < ActiveRecord::Migration[5.1]
  def self.up
    create_table :comments do |t|
      t.references :photo
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
