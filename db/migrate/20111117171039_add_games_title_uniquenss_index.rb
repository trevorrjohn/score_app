class AddGamesTitleUniquenssIndex < ActiveRecord::Migration

  def up
    add_index :games, :title, :unique => true
  end

  def down
    remove_index :games, :title
  end
end
