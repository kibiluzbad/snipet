class AddSnippetOwner < ActiveRecord::Migration
  def self.up
    change_table :snippets do |t|
      t.integer :user_id
    end
  end

  def self.down
    remove_column :snippets, :user_id
  end
end
