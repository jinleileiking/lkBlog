class CreatePagecontents < ActiveRecord::Migration
  def self.up
    create_table :pagecontents do |t|
      t.string :body
      t.integer :page_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pagecontents
  end
end
