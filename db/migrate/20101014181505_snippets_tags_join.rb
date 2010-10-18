class SnippetsTagsJoin < ActiveRecord::Migration
  def self.up
    create_table :snippets_tags, :id => false do |t|
      t.integer :snippet_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :snippets_tags
  end
end
