class VersionsAndBlob < ActiveRecord::Migration
  def self.up
    create_table :blobs, {:id => false} do |t|
      t.text :value, :null => false
      t.string :id, :null => false, :limit => 40
    end

    add_index :blobs, :id, :unique => true

    create_table :versions do |t|
      t.integer :blob_id, :null => false
      t.integer :previous_id
      t.text :metadata, :null => false, :default => "--- {}\n\n"

      t.timestamps
    end

  end

  def self.down
    drop_table :versions
    drop_table :blobs
  end
end
