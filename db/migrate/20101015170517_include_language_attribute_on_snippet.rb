class IncludeLanguageAttributeOnSnippet < ActiveRecord::Migration
  def self.up
    change_table :snippets do |t|
      t.string :language
    end
  end

  def self.down
    remove_column :snippets, :language
  end
end
