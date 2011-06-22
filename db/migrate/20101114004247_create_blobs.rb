class CreateBlobs < ActiveRecord::Migration
  def self.up
    create_table :blobs, :id => false do |t|
      t.text :value, :null => false
      t.string :id, :null => false, :limit => 40
    end

    add_index :blobs, :id, :unique => true
  end

  def self.down
    drop_table :blobs
  end
end
