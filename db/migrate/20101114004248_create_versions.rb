class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.string :blob_id, :null => false
      t.integer :previous_id
      t.text :metadata, :null => false, :default => "--- {}\n\n"

      t.timestamps
    end

  end

  def self.down
    drop_table :versions
  end
end
