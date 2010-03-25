class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.datetime :date
      t.boolean :isShare, :default => false
      t.timestamps
      t.integer :user_id
    end
  end

  def self.down
    drop_table :articles
  end
end
